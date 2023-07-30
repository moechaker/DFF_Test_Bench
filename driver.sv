class driver;
  
  transaction trans;
  mailbox #(transaction) mbxgd;
  event drvnext;
  virtual dff_if vif;
  
  function new(virtual dff_if vif, mailbox #(transaction) mbxgd, event drvnext);
    this.vif = vif;
    this.mbxgd = mbxgd;
    this.drvnext = drvnext;
  endfunction
  
  task reset();
    vif.rst <= 1'b1;
    repeat(5) @(posedge vif.clk);
    vif.rst <= 1'b0;
    @(posedge vif.clk);
    $display("[DRV] : RESET DONE");
  endtask
  
  task run();
    forever begin
      mbxgd.get(trans);
      vif.din <= trans.din;
      trans.display("DRV");
      @(posedge vif.clk);
      ->drvnext;
       
    end
    
  endtask
  
endclass