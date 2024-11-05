AXI stands for Advanced eXtensible Interface.
  It is a high-performance, parallel bus that connects processor cores to on-chip peripheral circuits.
  A high-performance, point-to-point, master-slave parallel bus that connects processor cores to on-chip peripheral circuits
  The AXI protocol defines the signals and timing of the point-to-point connections between masters and slaves.
  eg ARM processor is a master and slave is a memory conntroller.

  o each AXI master interface is connected to a single AXI slave
interface. Where multiple masters and slaves are involved, an interconnect fabric is required. This
interconnect fabric also implements slave and master interfaces, where the AXI protocol is
implemented
  the interconnect is a complex element that requires its own AXI master and slave interfaces to communicate with 
  external function blocks

Q. Why AXI have write response channel and don't have read response channel?
    Ans: Each channel is unidirectional, so a separate Write Response channel is needed to pass responses
back to the master. However, there is no need for a Read Response channel, because a read
response is passed as part of the Read Data channel.
  write address and data is happening from master to slave, response should come from slave to master i.e there is a dedicated channel
  for the write response. Whereas During read, the address send from master to slave,  and the data will come from slave ro master also
    the respone should come from slave to master so there is no separate read respone required. Incase of read with the transfer(beats)
    response will come alogn with that.

Q. Differences between transfers and transactions?
    Ans:
    Tansfer:A transfer is a single exchange of information, with one VALID and READY handshake. i.e completion of any single
    information like address, or data or response or control information.
    Transactions: A transaction is an entire burst of transfers, containing an address transfer, one or more data
    transfers, and, for write sequences, a response transfer. i.e. a complete data transaction(includes multiple transfers)
