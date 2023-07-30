class generator;
  transaction trans;
  mailbox #(transaction) mbxgd;
  mailbox #(transaction) mbxgs;
  event done;
  event drvnext;
  event sconext;
  int count;
  
  function new(mailbox #(transaction) mbxgd, mailbox #(transaction) mbxgs, event done, event drvnext, event sconext, int count);
    this.mbxgd = mbxgd;
    this.mbxgs = mbxgs;
    this.done = done;
    this.count = count;
    this.drvnext = drvnext;
    this.sconext = sconext;
    trans = new();
  endfunction
  
  task run();
    repeat(count) begin
      assert(trans.randomize()) else $error("[GEN] Randomization Failed!");
      mbxgd.put(trans.copy);
      mbxgs.put(trans.copy);
      trans.display("GEN");
      @drvnext;
      @sconext;
    end
    -> done;
    
  endtask
  
endclass