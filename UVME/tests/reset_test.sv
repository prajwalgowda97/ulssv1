class reset_test extends ulss_base_test;

  //factory registration
  `uvm_component_utils(reset_test)
  reset_sequence reset_sequence_inst;

  //constructor
  function new(string name = "reset_test",uvm_component parent);
    super.new(name,parent);
    reset_sequence_inst = reset_sequence::type_id::create("reset_sequence_inst");
  endfunction
 
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  //run phase
  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_full_name(),$sformatf("it test first line"),UVM_MEDIUM)
    phase.raise_objection(this);

    `uvm_info(get_type_name(),$sformatf("inside the reset test"),UVM_MEDIUM)
    
    begin
    reset_sequence_inst.scenario = 1;
    reset_sequence_inst.start(env.agent.sqr);
    end  
    `uvm_info(get_type_name(),$sformatf("reset scenario 1 is completed"),UVM_MEDIUM)
    
   // #20;
    
    begin
    reset_sequence_inst.scenario = 2;
    reset_sequence_inst.start(env.agent.sqr);
    end
    `uvm_info(get_type_name(),$sformatf("reset scenario 2 is completed"),UVM_MEDIUM)

   // phase.phase_done.set_drain_time(this,1000);
#1000;
    phase.drop_objection(this);
  endtask

endclass
