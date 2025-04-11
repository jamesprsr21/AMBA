module apb_assertion(input bit pwrite, bit[31:0]pwdata, bit[31:0]paddr, bit pready, bit[31:0]prdata, bit presetn, bit psel, bit enable, bit pclk);

  //Reset checking- after reset all signals should in default state.
  property p0;
    @(posedge pclk)
    (!presetn) |-> (psel==1'b0 && penable==1'b0 && pready==1'b0 && paddr=='b0 && pwdata=='b0 && prdata=='b0 && pslverr==1'b0);
  endproperty

  //Handshaking - when penable is high and from the same posedge pready gets high for one cylce, then in the next cyce penable and pready become blow.
  property p1;
    @(posedge pclk) disable iff(!presetn) 
    $rose(penable) |-> pready[->1] ##1 $fell(penable) && $fell(pready); 
  endproperty

  //Write operation
    property p2;
    @(posedge pclk) disable iff(!presetn) 
      $rose(pwrite && psel) |-> $stable(paddr && pwdata) |=> $rose(penable) |-> ##[0:15]$rose(pready) ##1 $fell(psel && pwrite && penable && pready);   
  endproperty

    //Read operation
    property p3;
    @(posedge pclk) disable iff(!presetn) 
      (!pwrite && psel) |-> $stable(paddr && prdata) |=> $rose(penable) |-> ##[0:15]$rose(pready) ##1 $fell(psel && pwrite && penable && pready);   
  endproperty

  property p4;
    @(posedge pclk) disable iff(!presetn)
    $fell(psel && penable && pready) |-> !pslverr; 
  endproperty

  property p5;
    @(posedge clk) disable iff(!presetn)
    paddr>= 2^32 |-> $rose(pslverr);
  endproperty

    property p6;
    @(posedge clk) disable iff(!presetn)
      $rose(penable) |-> (##[15]!pready && ##[16:$]pready) |-> $rose(pslverr);
  endproperty
  //or
  property p6;
    @(posedge clk) disable iff(!presetn)
    $rose(penable) |-> (!pready[->15] && ##[16:$]pready) |-> $rose(pslverr);
  endproperty

  //after psel asserted then in next cycle penable asserted
  property p7;
    @(posedge clk) disable iff(!presetn)
    $rose(psel) |=> $rose(penable);
  endproperty

  //if trying to write in a read_only memory(let say 4 is the RO location) 
  property p8;
    @(posedge pclk) disable iff(!presetn)
    pwrite && padder[15:0]==16'b04 |-> $rose(pslverr);
  endproperty

  //if trying to read in a write_only memory(let say 4 is the WO location) 
  property p9;
    @(posedge pclk) disable iff(!presetn)
    !pwrite && padder[15:0]==16'b08 |-> $rose(pslverr);
  endproperty

  
  

  
