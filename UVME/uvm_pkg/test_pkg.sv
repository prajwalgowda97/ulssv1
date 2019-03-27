package test_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "./../UVME/sequence/ulss_tx.sv"

    `include "./../UVME/sequence/ulss_base_sequence.sv"
    `include "./../UVME/sequence/reset_sequence.sv"


    `include "./../UVME/agent/ulss_driver.sv"
    `include "./../UVME/agent/ulss_monitor.sv"
    `include "./../UVME/agent/ulss_sequencer.sv"
    `include "./../UVME/agent/ulss_agent.sv"
    //`include "./../UVME/env/ulss_scoreboard.sv"
    `include "./../UVME/env/ulss_env.sv"
    //`include "./../UVME/sequence/ulss_base_sequence.sv"
    `include "./../UVME/tests/ulss_base_test.sv"
    `include "./../UVME/tests/reset_test.sv"
    
    endpackage
