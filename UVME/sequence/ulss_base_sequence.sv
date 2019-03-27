class ulss_base_sequence extends uvm_sequence#(ulss_tx);

  //factory registration
  `uvm_object_utils(ulss_base_sequence)

  //creating sequence item handle
  ulss_tx tx;


  //constructor
  function new(string name="ulss_base_sequence");
   super.new(name);
  endfunction

  //task body
  task body();
 start_item(tx);

 finish_item(tx);
         
  endtask

endclass
