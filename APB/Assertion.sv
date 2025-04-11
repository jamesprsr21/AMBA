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

  
