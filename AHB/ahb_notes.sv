AHB stands for Advanced High Perfomance Bus
  Supprts multi-master Multi-slave 
  point to point communication
Q.why ahb is single clock edge operation?
Ans: 
  o The Advanced High-performance Bus (AHB) is a single clock-edge protocol because it synchronizes all transactions to a 
  single clock, which simplifies the system's timing design. Only the rising edge of the clock is used to transfer information 
  from source to destination
  o Single clock-edge operation: All transactions are synchronized to a single clock. 
  o Pipelined operation: Overlapping of address and data phases improves throughput. 
  o Split transactions: Slaves can release the bus while waiting for resources, making the bus available for other transactions. 
  o Multiple masters and slaves: AHB supports multiple master devices and multiple slaves. 
  o Point-to-point read bus: Point-to-point linkages between each slave and the read multiplexer speeds up the bus. 
