class transaction;
  
  rand bit din;
  bit dout;
  
  function void display(string tag);
    $display("[%0s] din = %0d  dout = %0d",tag,din,dout);
  endfunction
  
  function transaction copy();
    copy = new();
    copy.din = this.din;
    copy.dout = this.dout;
  endfunction
  
endclass