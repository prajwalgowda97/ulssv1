class ulss_base_sequence extends uvm_sequence#(ulss_tx);
  // Factory registration
  `uvm_object_utils(ulss_base_sequence)
  
  // Transaction handle
  ulss_tx tx;
  
  // Constructor
  function new(string name="ulss_base_sequence");
    super.new(name);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    // No super call needed for sequences
    tx = ulss_tx::type_id::create("tx");
  endfunction
  
  // Task body - default implementation
  task body();
    tx = ulss_tx::type_id::create("tx");
    
    start_item(tx);
    // Configure default values if needed
    finish_item(tx);
  endtask
endclass
