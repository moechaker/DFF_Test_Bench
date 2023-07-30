class scoreboard;
  transaction trans;
  transaction temp;
  mailbox #(transaction) mbxgs;
  mailbox #(transaction) mbxms;
  event sconext;
  
  
  
  function new(mailbox #(transaction) mbxgs, mailbox #(transaction) mbxms, event sconext);
    this.mbxgs = mbxgs;
    this.mbxms = mbxms;
    this.sconext = sconext;
  endfunction
  
  task run();
    
    forever begin
      mbxgs.get(temp);
      mbxms.get(trans);
      trans.display("SCO");
      if(temp.din == trans.dout)
        $display("Data Match");
      else
        $display("Data Mismatch");
      
      ->sconext;
    end
    
  endtask
  
  
endclass