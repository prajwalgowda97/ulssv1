/*class ulss_driver extends uvm_driver #(ulss_tx);

  // Factory registration
  `uvm_component_utils(ulss_driver)

  // Creating interface and sequence item handle
  ulss_tx tx;
  virtual ulss_interface vif;

  // Constructor
  function new(string name = "ulss_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx = ulss_tx::type_id::create("tx");
    if(!uvm_config_db#(virtual ulss_interface)::get(this,"*","ulss_interface",vif))
      `uvm_fatal(get_full_name(),"Unable to get interface in driver")
  endfunction

  task run_phase(uvm_phase phase);
    // Initial reset sequence
    @(posedge vif.rate_limiter_16to4_clk);
    vif.rate_limiter_16to4_rstn <= 1'b0;    
    
    // Initialize register signals to 1'b0
    vif.sch_reg_wr_en <= 1'b0;
    vif.sch_reg_wr_addr <= 5'b0;
    vif.sch_reg_wr_data <= 64'b0;   
    
    // Initialize all input stream signals to 1'b0
    vif.in_sop_0 <= 1'b0; vif.in_stream_0 <= 64'b0; vif.in_eop_0 <= 1'b0;
    vif.in_sop_1 <= 1'b0; vif.in_stream_1 <= 64'b0; vif.in_eop_1 <= 1'b0;
    vif.in_sop_2 <= 1'b0; vif.in_stream_2 <= 64'b0; vif.in_eop_2 <= 1'b0;
    vif.in_sop_3 <= 1'b0; vif.in_stream_3 <= 64'b0; vif.in_eop_3 <= 1'b0;
    vif.in_sop_4 <= 1'b0; vif.in_stream_4 <= 64'b0; vif.in_eop_4 <= 1'b0;
    vif.in_sop_5 <= 1'b0; vif.in_stream_5 <= 64'b0; vif.in_eop_5 <= 1'b0;
    vif.in_sop_6 <= 1'b0; vif.in_stream_6 <= 64'b0; vif.in_eop_6 <= 1'b0;
    vif.in_sop_7 <= 1'b0; vif.in_stream_7 <= 64'b0; vif.in_eop_7 <= 1'b0;
    vif.in_sop_8 <= 1'b0; vif.in_stream_8 <= 64'b0; vif.in_eop_8 <= 1'b0;
    vif.in_sop_9 <= 1'b0; vif.in_stream_9 <= 64'b0; vif.in_eop_9 <= 1'b0;
    vif.in_sop_10 <= 1'b0; vif.in_stream_10 <= 64'b0; vif.in_eop_10 <= 1'b0;
    vif.in_sop_11 <= 1'b0; vif.in_stream_11 <= 64'b0; vif.in_eop_11 <= 1'b0;
    vif.in_sop_12 <= 1'b0; vif.in_stream_12 <= 64'b0; vif.in_eop_12 <= 1'b0;
    vif.in_sop_13 <= 1'b0; vif.in_stream_13 <= 64'b0; vif.in_eop_13 <= 1'b0;
    vif.in_sop_14 <= 1'b0; vif.in_stream_14 <= 64'b0; vif.in_eop_14 <= 1'b0;
    vif.in_sop_15 <= 1'b0; vif.in_stream_15 <= 64'b0; vif.in_eop_15 <= 1'b0;

    vif.pck_str_empty_0 <= 1'b0;
    vif.pck_str_empty_1 <= 1'b0;
    vif.pck_str_empty_2 <= 1'b0;
    vif.pck_str_empty_3 <= 1'b0;
    vif.pck_str_empty_4 <= 1'b0;
    vif.pck_str_empty_5 <= 1'b0;
    vif.pck_str_empty_6 <= 1'b0;
    vif.pck_str_empty_7 <= 1'b0;
    vif.pck_str_empty_8 <= 1'b0;
    vif.pck_str_empty_9 <= 1'b0;
    vif.pck_str_empty_10 <= 1'b0;            
    vif.pck_str_empty_11 <= 1'b0;
    vif.pck_str_empty_12 <= 1'b0;
    vif.pck_str_empty_13 <= 1'b0;           
    vif.pck_str_empty_14 <= 1'b0;           
    vif.pck_str_empty_15 <= 1'b0;

    repeat(3) @(posedge vif.rate_limiter_16to4_clk);
    vif.rate_limiter_16to4_rstn <= 1'b1;

    forever begin
      seq_item_port.get_next_item(tx);
      
      // 1. Apply reset and register config signals
      vif.rate_limiter_16to4_rstn <= tx.rate_limiter_16to4_rstn;
      vif.sch_reg_wr_en <= tx.sch_reg_wr_en;
      vif.sch_reg_wr_addr <= tx.sch_reg_wr_addr;
      vif.sch_reg_wr_data <= tx.sch_reg_wr_data;
      
      @(posedge vif.rate_limiter_16to4_clk);
      
      // If reset is inactive, then proceed with packet transfer
      if (tx.rate_limiter_16to4_rstn == 1'b1) begin
        // Handle each stream individually using the flattened signals
        // Stream 0
        vif.pck_str_empty_0 <= tx.pck_str_empty_0;
        if (tx.pck_str_empty_0 == 1'b0) begin  // Non-empty packet to send
          wait(vif.pck_rd_en_grnt_0);
          vif.in_sop_0 <= tx.in_sop_0;
          vif.in_stream_0 <= tx.in_stream_0;
          vif.in_eop_0 <= tx.in_eop_0;
        end
        
        // Stream 1
        vif.pck_str_empty_1 <= tx.pck_str_empty_1;
        if (tx.pck_str_empty_1 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_1);
          vif.in_sop_1 <= tx.in_sop_1;
          vif.in_stream_1 <= tx.in_stream_1;
          vif.in_eop_1 <= tx.in_eop_1;
        end
        
        
        // Stream 2
        vif.pck_str_empty_2 <= tx.pck_str_empty_2;
        if (tx.pck_str_empty_2 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_2);
          vif.in_sop_2 <= tx.in_sop_2;
          vif.in_stream_2 <= tx.in_stream_2;
          vif.in_eop_2 <= tx.in_eop_2;
        end


        // Stream 3
        vif.pck_str_empty_3 <= tx.pck_str_empty_3;
        if (tx.pck_str_empty_3 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_3);
          vif.in_sop_3 <= tx.in_sop_3;
          vif.in_stream_3 <= tx.in_stream_3;
          vif.in_eop_3 <= tx.in_eop_3;
        end        


        // Stream 4
        vif.pck_str_empty_4 <= tx.pck_str_empty_4;
        if (tx.pck_str_empty_4 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_4);
          vif.in_sop_4 <= tx.in_sop_4;
          vif.in_stream_4 <= tx.in_stream_4;
          vif.in_eop_4 <= tx.in_eop_4;
        end        


        // Stream 5
        vif.pck_str_empty_5 <= tx.pck_str_empty_5;
        if (tx.pck_str_empty_5 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_5);
          vif.in_sop_5 <= tx.in_sop_5;
          vif.in_stream_5 <= tx.in_stream_5;
          vif.in_eop_5 <= tx.in_eop_5;
        end        
 

        // Stream 6
        vif.pck_str_empty_6 <= tx.pck_str_empty_6;
        if (tx.pck_str_empty_6 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_6);
          vif.in_sop_6 <= tx.in_sop_6;
          vif.in_stream_6 <= tx.in_stream_6;
          vif.in_eop_6 <= tx.in_eop_6;
        end        


        // Stream 7
        vif.pck_str_empty_7 <= tx.pck_str_empty_7;
        if (tx.pck_str_empty_7 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_7);
          vif.in_sop_7 <= tx.in_sop_7;
          vif.in_stream_7 <= tx.in_stream_7;
          vif.in_eop_7 <= tx.in_eop_7;
        end        


        // Stream 8
        vif.pck_str_empty_8 <= tx.pck_str_empty_8;
        if (tx.pck_str_empty_8 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_8);
          vif.in_sop_8 <= tx.in_sop_8;
          vif.in_stream_8 <= tx.in_stream_8;
          vif.in_eop_8 <= tx.in_eop_8;
        end        


        // Stream 9
        vif.pck_str_empty_9 <= tx.pck_str_empty_9;
        if (tx.pck_str_empty_9 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_9);
          vif.in_sop_9 <= tx.in_sop_9;
          vif.in_stream_9 <= tx.in_stream_9;
          vif.in_eop_9 <= tx.in_eop_9;
        end        


        // Stream 10
        vif.pck_str_empty_10 <= tx.pck_str_empty_10;
        if (tx.pck_str_empty_10 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_10);
          vif.in_sop_10 <= tx.in_sop_10;
          vif.in_stream_10 <= tx.in_stream_10;
          vif.in_eop_10 <= tx.in_eop_10;
        end        


        // Stream 11
        vif.pck_str_empty_11 <= tx.pck_str_empty_11;
        if (tx.pck_str_empty_11 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_11);
          vif.in_sop_11 <= tx.in_sop_11;
          vif.in_stream_11 <= tx.in_stream_11;
          vif.in_eop_11 <= tx.in_eop_11;
        end        


        // Stream 12
        vif.pck_str_empty_12 <= tx.pck_str_empty_12;
        if (tx.pck_str_empty_12 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_12);
          vif.in_sop_12 <= tx.in_sop_12;
          vif.in_stream_12 <= tx.in_stream_12;
          vif.in_eop_12 <= tx.in_eop_12;
        end        
 

        // Stream 13
        vif.pck_str_empty_13 <= tx.pck_str_empty_13;
        if (tx.pck_str_empty_13 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_13);
          vif.in_sop_13 <= tx.in_sop_13;
          vif.in_stream_13 <= tx.in_stream_13;
          vif.in_eop_13 <= tx.in_eop_13;
        end        


        // Stream 14
        vif.pck_str_empty_14 <= tx.pck_str_empty_14;
        if (tx.pck_str_empty_14 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_14);
          vif.in_sop_14 <= tx.in_sop_14;
          vif.in_stream_14 <= tx.in_stream_14;
          vif.in_eop_14 <= tx.in_eop_14;
        end        


        // Stream 15
        vif.pck_str_empty_15 <= tx.pck_str_empty_15;
        if (tx.pck_str_empty_15 == 1'b0) begin
          wait(vif.pck_rd_en_grnt_15);
          vif.in_sop_15 <= tx.in_sop_15;
          vif.in_stream_15 <= tx.in_stream_15;
          vif.in_eop_15 <= tx.in_eop_15;
        end   
        
        // Wait for one clock cycle after applying all signals
        @(posedge vif.rate_limiter_16to4_clk);
      end
      
      seq_item_port.item_done();
    end
  endtask
endclass */

class ulss_driver extends uvm_driver #(ulss_tx);

  // Factory registration
  `uvm_component_utils(ulss_driver)

  // Creating interface and sequence item handle
  ulss_tx tx;
  virtual ulss_interface vif;

  // Control flags
  bit stop_driver = 0;

  // Constructor
  function new(string name = "ulss_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx = ulss_tx::type_id::create("tx");
    if(!uvm_config_db#(virtual ulss_interface)::get(this,"*","ulss_interface",vif))
      `uvm_fatal(get_full_name(),"Unable to get interface in driver")
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    // Initial reset sequence
    @(posedge vif.rate_limiter_16to4_clk);
    vif.rate_limiter_16to4_rstn <= 1'b0;    
    
    // Initialize register signals to 1'b0
    vif.sch_reg_wr_en <= 1'b0;
    vif.sch_reg_wr_addr <= 5'b0;
    vif.sch_reg_wr_data <= 64'b0;   
    
    // Initialize all input stream signals to 1'b0
    vif.in_sop_0 <= 1'b0; vif.in_stream_0 <= 64'b0; vif.in_eop_0 <= 1'b0;
    vif.in_sop_1 <= 1'b0; vif.in_stream_1 <= 64'b0; vif.in_eop_1 <= 1'b0;
    vif.in_sop_2 <= 1'b0; vif.in_stream_2 <= 64'b0; vif.in_eop_2 <= 1'b0;
    vif.in_sop_3 <= 1'b0; vif.in_stream_3 <= 64'b0; vif.in_eop_3 <= 1'b0;
    vif.in_sop_4 <= 1'b0; vif.in_stream_4 <= 64'b0; vif.in_eop_4 <= 1'b0;
    vif.in_sop_5 <= 1'b0; vif.in_stream_5 <= 64'b0; vif.in_eop_5 <= 1'b0;
    vif.in_sop_6 <= 1'b0; vif.in_stream_6 <= 64'b0; vif.in_eop_6 <= 1'b0;
    vif.in_sop_7 <= 1'b0; vif.in_stream_7 <= 64'b0; vif.in_eop_7 <= 1'b0;
    vif.in_sop_8 <= 1'b0; vif.in_stream_8 <= 64'b0; vif.in_eop_8 <= 1'b0;
    vif.in_sop_9 <= 1'b0; vif.in_stream_9 <= 64'b0; vif.in_eop_9 <= 1'b0;
    vif.in_sop_10 <= 1'b0; vif.in_stream_10 <= 64'b0; vif.in_eop_10 <= 1'b0;
    vif.in_sop_11 <= 1'b0; vif.in_stream_11 <= 64'b0; vif.in_eop_11 <= 1'b0;
    vif.in_sop_12 <= 1'b0; vif.in_stream_12 <= 64'b0; vif.in_eop_12 <= 1'b0;
    vif.in_sop_13 <= 1'b0; vif.in_stream_13 <= 64'b0; vif.in_eop_13 <= 1'b0;
    vif.in_sop_14 <= 1'b0; vif.in_stream_14 <= 64'b0; vif.in_eop_14 <= 1'b0;
    vif.in_sop_15 <= 1'b0; vif.in_stream_15 <= 64'b0; vif.in_eop_15 <= 1'b0;

    vif.pck_str_empty_0 <= 1'b0;
    vif.pck_str_empty_1 <= 1'b0;
    vif.pck_str_empty_2 <= 1'b0;
    vif.pck_str_empty_3 <= 1'b0;
    vif.pck_str_empty_4 <= 1'b0;
    vif.pck_str_empty_5 <= 1'b0;
    vif.pck_str_empty_6 <= 1'b0;
    vif.pck_str_empty_7 <= 1'b0;
    vif.pck_str_empty_8 <= 1'b0;
    vif.pck_str_empty_9 <= 1'b0;
    vif.pck_str_empty_10 <= 1'b0;            
    vif.pck_str_empty_11 <= 1'b0;
    vif.pck_str_empty_12 <= 1'b0;
    vif.pck_str_empty_13 <= 1'b0;           
    vif.pck_str_empty_14 <= 1'b0;           
    vif.pck_str_empty_15 <= 1'b0;

    repeat(3) @(posedge vif.rate_limiter_16to4_clk);
    vif.rate_limiter_16to4_rstn <= 1'b1;

    fork
      // Main driver process
      begin
        while (!stop_driver) begin
          // Try to get next item with timeout
          fork
            begin
              seq_item_port.get_next_item(tx);
              `uvm_info(get_type_name(), $sformatf("Driver received item: rst=%0d", tx.rate_limiter_16to4_rstn), UVM_DEBUG)
              
              // 1. Apply reset and register config signals
              vif.rate_limiter_16to4_rstn <= tx.rate_limiter_16to4_rstn;
              vif.sch_reg_wr_en <= tx.sch_reg_wr_en;
              vif.sch_reg_wr_addr <= tx.sch_reg_wr_addr;
              vif.sch_reg_wr_data <= tx.sch_reg_wr_data;
              
              @(posedge vif.rate_limiter_16to4_clk);
              
              // If reset is inactive, then proceed with packet transfer
              if (tx.rate_limiter_16to4_rstn == 1'b1) begin
                // Handle each stream individually using the flattened signals
                // Stream 0
                vif.pck_str_empty_0 <= tx.pck_str_empty_0;
                if (tx.pck_str_empty_0 == 1'b0) begin  // Non-empty packet to send
                  wait(vif.pck_rd_en_grnt_0);
                  vif.in_sop_0 <= tx.in_sop_0;
                  vif.in_stream_0 <= tx.in_stream_0;
                  vif.in_eop_0 <= tx.in_eop_0;
                end
                
                vif.pck_str_empty_1 <= tx.pck_str_empty_1;
                if (tx.pck_str_empty_1 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_1);
                  vif.in_sop_1 <= tx.in_sop_1;
                  vif.in_stream_1 <= tx.in_stream_1;
                  vif.in_eop_1 <= tx.in_eop_1;
                end

                vif.pck_str_empty_2 <= tx.pck_str_empty_2;
                if (tx.pck_str_empty_2 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_2);
                  vif.in_sop_2 <= tx.in_sop_2;
                  vif.in_stream_2 <= tx.in_stream_2;
                  vif.in_eop_2 <= tx.in_eop_2;
                end

                vif.pck_str_empty_3 <= tx.pck_str_empty_3;
                if (tx.pck_str_empty_3 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_3);
                  vif.in_sop_3 <= tx.in_sop_3;
                  vif.in_stream_3 <= tx.in_stream_3;
                  vif.in_eop_3 <= tx.in_eop_3;
                end
                

                vif.pck_str_empty_4 <= tx.pck_str_empty_4;
                if (tx.pck_str_empty_4 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_4);
                  vif.in_sop_4 <= tx.in_sop_4;
                  vif.in_stream_4 <= tx.in_stream_4;
                  vif.in_eop_4 <= tx.in_eop_4;
                end
                

                vif.pck_str_empty_5 <= tx.pck_str_empty_5;
                if (tx.pck_str_empty_5 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_5);
                  vif.in_sop_5 <= tx.in_sop_5;
                  vif.in_stream_5 <= tx.in_stream_5;
                  vif.in_eop_5 <= tx.in_eop_5;
                end
                

                vif.pck_str_empty_6 <= tx.pck_str_empty_6;
                if (tx.pck_str_empty_6 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_6);
                  vif.in_sop_6 <= tx.in_sop_6;
                  vif.in_stream_6 <= tx.in_stream_6;
                  vif.in_eop_6 <= tx.in_eop_6;
                end
                

                vif.pck_str_empty_7 <= tx.pck_str_empty_7;
                if (tx.pck_str_empty_7 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_7);
                  vif.in_sop_7 <= tx.in_sop_7;
                  vif.in_stream_7 <= tx.in_stream_7;
                  vif.in_eop_7 <= tx.in_eop_7;
                end
                

                vif.pck_str_empty_8 <= tx.pck_str_empty_8;
                if (tx.pck_str_empty_8 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_8);
                  vif.in_sop_8 <= tx.in_sop_8;
                  vif.in_stream_8 <= tx.in_stream_8;
                  vif.in_eop_8 <= tx.in_eop_8;
                end
                

                vif.pck_str_empty_9 <= tx.pck_str_empty_9;
                if (tx.pck_str_empty_9 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_9);
                  vif.in_sop_9 <= tx.in_sop_9;
                  vif.in_stream_9 <= tx.in_stream_9;
                  vif.in_eop_9 <= tx.in_eop_9;
                end
                

                vif.pck_str_empty_10 <= tx.pck_str_empty_10;
                if (tx.pck_str_empty_10 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_10);
                  vif.in_sop_10 <= tx.in_sop_10;
                  vif.in_stream_10 <= tx.in_stream_10;
                  vif.in_eop_10 <= tx.in_eop_10;
                end
                

                vif.pck_str_empty_11 <= tx.pck_str_empty_11;
                if (tx.pck_str_empty_11 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_11);
                  vif.in_sop_11 <= tx.in_sop_11;
                  vif.in_stream_11 <= tx.in_stream_11;
                  vif.in_eop_11 <= tx.in_eop_11;
                end
                

                vif.pck_str_empty_12 <= tx.pck_str_empty_12;
                if (tx.pck_str_empty_12 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_12);
                  vif.in_sop_12 <= tx.in_sop_12;
                  vif.in_stream_12 <= tx.in_stream_12;
                  vif.in_eop_12 <= tx.in_eop_12;
                end
                

                vif.pck_str_empty_13 <= tx.pck_str_empty_13;
                if (tx.pck_str_empty_13 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_13);
                  vif.in_sop_13 <= tx.in_sop_13;
                  vif.in_stream_13 <= tx.in_stream_13;
                  vif.in_eop_13 <= tx.in_eop_13;
                end
                

                vif.pck_str_empty_14 <= tx.pck_str_empty_14;
                if (tx.pck_str_empty_14 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_14);
                  vif.in_sop_14 <= tx.in_sop_14;
                  vif.in_stream_14 <= tx.in_stream_14;
                  vif.in_eop_14 <= tx.in_eop_14;
                end
                

                vif.pck_str_empty_15 <= tx.pck_str_empty_15;
                if (tx.pck_str_empty_15 == 1'b0) begin
                  wait(vif.pck_rd_en_grnt_15);
                  vif.in_sop_15 <= tx.in_sop_15;
                  vif.in_stream_15 <= tx.in_stream_15;
                  vif.in_eop_15 <= tx.in_eop_15;
                end
                                
                
                // Wait for one clock cycle after applying all signals
                @(posedge vif.rate_limiter_16to4_clk);
              end
              
              seq_item_port.item_done();
            end
            
            begin
              // Add a watchdog timeout to prevent deadlock
              repeat(1000) @(posedge vif.rate_limiter_16to4_clk);
              `uvm_warning(get_type_name(), "Timeout waiting for next sequence item")
              stop_driver = 1;
            end
          join_any
          disable fork;
          
          if (stop_driver) break;
        end
      end
      
      // Simulation watchdog
      begin
        // Overall simulation timeout (adjust as needed)
        repeat(10000) @(posedge vif.rate_limiter_16to4_clk);
        `uvm_warning(get_type_name(), "Global simulation timeout reached, ending simulation")
        stop_driver = 1;
      end
    join_any
    
    // Wait a few more cycles to complete any pending transactions
    repeat(10) @(posedge vif.rate_limiter_16to4_clk);
    
    phase.drop_objection(this);
  endtask
endclass
