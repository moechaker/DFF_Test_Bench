class monitor;
  transaction trans;
  mailbox #(transaction) mbxms;
  virtual dff_if vif;
  
  function new(virtual dff_if vif, mailbox #(transaction) mbxms);
    this.vif = vif;
    this.mbxms = mbxms;
  endfunction
  
  task run();
    trans = new();
    forever begin
      @(posedge vif.clk);
      @(posedge vif.clk);
      trans.dout = vif.dout;
      mbxms.put(trans);
      trans.display("MON");
    end
    
  endtask
  
endclass