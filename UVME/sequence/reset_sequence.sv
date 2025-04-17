/* class reset_sequence extends ulss_base_sequence;

  // Factory registration
  `uvm_object_utils(reset_sequence)

  // Creating sequence item handle
  //ulss_req req;
  ulss_tx req; // Added missing declaration

  int scenario;
  int sid;

  // Constructor
  function new(string name="reset_sequence");
    super.new(name);
  endfunction
  
  // Build phase - corrected with super call
  function void build_phase(uvm_phase phase);
    //super.build_phase(phase);
   // req = ulss_req::type_id::create("req");
  endfunction

  task body();
    req = ulss_tx::type_id::create("req");
    if(scenario == 1) begin 
      // Step 1: Assert active low reset
      `uvm_do_with(req, {
        req.rate_limiter_16to4_rstn == 0;   
        // Initialize register signals to 0
        req.sch_reg_wr_en == 0;
        req.sch_reg_wr_addr == 0;
        req.sch_reg_wr_data == 0;   
        // Initialize all input stream signals to 0
        req.in_sop_0 == 0; req.in_stream_0 == 0; req.in_eop_0 == 0;
        req.in_sop_1 == 0; req.in_stream_1 == 0; req.in_eop_1 == 0;
        req.in_sop_2 == 0; req.in_stream_2 == 0; req.in_eop_2 == 0;
        req.in_sop_3 == 0; req.in_stream_3 == 0; req.in_eop_3 == 0;
        req.in_sop_4 == 0; req.in_stream_4 == 0; req.in_eop_4 == 0;
        req.in_sop_5 == 0; req.in_stream_5 == 0; req.in_eop_5 == 0;
        req.in_sop_6 == 0; req.in_stream_6 == 0; req.in_eop_6 == 0;
        req.in_sop_7 == 0; req.in_stream_7 == 0; req.in_eop_7 == 0;
        req.in_sop_8 == 0; req.in_stream_8 == 0; req.in_eop_8 == 0;
        req.in_sop_9 == 0; req.in_stream_9 == 0; req.in_eop_9 == 0;
        req.in_sop_10 == 0; req.in_stream_10 == 0; req.in_eop_10 == 0;
        req.in_sop_11 == 0; req.in_stream_11 == 0; req.in_eop_11 == 0;
        req.in_sop_12 == 0; req.in_stream_12 == 0; req.in_eop_12 == 0;
        req.in_sop_13 == 0; req.in_stream_13 == 0; req.in_eop_13 == 0;
        req.in_sop_14 == 0; req.in_stream_14 == 0; req.in_eop_14 == 0;
        req.in_sop_15 == 0; req.in_stream_15 == 0; req.in_eop_15 == 0;

        req.pck_str_empty_0 == 0;
        req.pck_str_empty_1 == 0;
        req.pck_str_empty_2 == 0;
        req.pck_str_empty_3 == 0;
        req.pck_str_empty_4 == 0;
        req.pck_str_empty_5 == 0;
        req.pck_str_empty_6 == 0;
        req.pck_str_empty_7 == 0;
        req.pck_str_empty_8 == 0;
        req.pck_str_empty_9 == 0;
        req.pck_str_empty_10 == 0;            
        req.pck_str_empty_11 == 0;
        req.pck_str_empty_12 == 0;
        req.pck_str_empty_13 == 0;           
        req.pck_str_empty_14 == 0;           
        req.pck_str_empty_15 == 0; 
      });
      $display("Reset signal is successfully generated in sequence=%b", req.rate_limiter_16to4_rstn);
    end

    if(scenario == 2) begin
      // First, deassert reset
      `uvm_do_with(req, {
        req.rate_limiter_16to4_rstn == 1;
        // Keep all other signals at their default values
      });

      // Create and initialize req since we're using it below
      req = ulss_tx::type_id::create("req");
      
      // Configure OUT_STREAM_0_REG
      start_item(req);
      req.sch_reg_wr_en   = 1'b1;
      req.sch_reg_wr_addr = 5'd0; // OUT_STREAM_0_REG
      req.sch_reg_wr_data = 64'h0000_0000_0000_0001; // Input stream 0 mapped
      finish_item(req);

      // Configure IN_STREAM_0_REG
      start_item(req);
      req.sch_reg_wr_en   = 1'b1;
      req.sch_reg_wr_addr = 5'd4; // IN_STREAM_0_REG
      req.sch_reg_wr_data = {49'd1, 15'd0}; // 1 packet, token wait 0
      finish_item(req);

      // Send start of packet on stream 0
      start_item(req);
      req.pck_str_empty_0 = 1'b0; // Non-empty packet for stream 0
      req.in_sop_0        = 1'b1; // Start of packet
      req.in_stream_0     = 64'h1234_5678_DEAD_BEEF; // Packet data
      req.in_eop_0        = 1'b0; // Not end of packet yet
      finish_item(req);

      // Complete packet transmission with end of packet
      start_item(req);
      req.pck_str_empty_0 = 1'b0;
      req.in_sop_0        = 1'b0; // Not start
      req.in_stream_0     = 64'h0; // Could be different data if needed
      req.in_eop_0        = 1'b1; // End of packet
      finish_item(req);
      
      // Reset signals after packet transmission
      start_item(req);
      req.pck_str_empty_0 = 1'b1; // Empty again
      req.in_sop_0        = 1'b0;
      req.in_stream_0     = 64'h0;
      req.in_eop_0        = 1'b0;
      finish_item(req);

      `uvm_info("ULSS", $sformatf("Stream 0 packet sent"), UVM_LOW)
      `uvm_info(get_type_name(), "Starting ULSS Sequence for Stream 0 Only", UVM_MEDIUM)   
      $display("Reset signal is successfully generated in sequence=%b", req.rate_limiter_16to4_rstn);
    end
  endtask
endclass */

class reset_sequence extends ulss_base_sequence;

  // Factory registration
  `uvm_object_utils(reset_sequence)

  // Creating sequence item handle
  ulss_tx req;

  int scenario;
  int sid;

  // Constructor
  function new(string name="reset_sequence");
    super.new(name);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    // Not needed for sequences
  endfunction

  task body();
    req = ulss_tx::type_id::create("req");
    
    if(scenario == 1) begin 
      // Step 1: Assert active low reset
      `uvm_do_with(req, {
        req.rate_limiter_16to4_rstn == 0;   
        // Initialize register signals to 0
        req.sch_reg_wr_en == 0;
        req.sch_reg_wr_addr == 0;
        req.sch_reg_wr_data == 0;   
        // Initialize all input stream signals to 0
        req.in_sop_0 == 0; req.in_stream_0 == 0; req.in_eop_0 == 0;
        req.in_sop_1 == 0; req.in_stream_1 == 0; req.in_eop_1 == 0;
        req.in_sop_2 == 0; req.in_stream_2 == 0; req.in_eop_2 == 0;
        req.in_sop_3 == 0; req.in_stream_3 == 0; req.in_eop_3 == 0;
        req.in_sop_4 == 0; req.in_stream_4 == 0; req.in_eop_4 == 0;
        req.in_sop_5 == 0; req.in_stream_5 == 0; req.in_eop_5 == 0;
        req.in_sop_6 == 0; req.in_stream_6 == 0; req.in_eop_6 == 0;
        req.in_sop_7 == 0; req.in_stream_7 == 0; req.in_eop_7 == 0;
        req.in_sop_8 == 0; req.in_stream_8 == 0; req.in_eop_8 == 0;
        req.in_sop_9 == 0; req.in_stream_9 == 0; req.in_eop_9 == 0;
        req.in_sop_10 == 0; req.in_stream_10 == 0; req.in_eop_10 == 0;
        req.in_sop_11 == 0; req.in_stream_11 == 0; req.in_eop_11 == 0;
        req.in_sop_12 == 0; req.in_stream_12 == 0; req.in_eop_12 == 0;
        req.in_sop_13 == 0; req.in_stream_13 == 0; req.in_eop_13 == 0;
        req.in_sop_14 == 0; req.in_stream_14 == 0; req.in_eop_14 == 0;
        req.in_sop_15 == 0; req.in_stream_15 == 0; req.in_eop_15 == 0;

        req.pck_str_empty_0 == 0;
        req.pck_str_empty_1 == 0;
        req.pck_str_empty_2 == 0;
        req.pck_str_empty_3 == 0;
        req.pck_str_empty_4 == 0;
        req.pck_str_empty_5 == 0;
        req.pck_str_empty_6 == 0;
        req.pck_str_empty_7 == 0;
        req.pck_str_empty_8 == 0;
        req.pck_str_empty_9 == 0;
        req.pck_str_empty_10 == 0;            
        req.pck_str_empty_11 == 0;
        req.pck_str_empty_12 == 0;
        req.pck_str_empty_13 == 0;           
        req.pck_str_empty_14 == 0;           
        req.pck_str_empty_15 == 0; 
      });
      $display("Reset signal is successfully generated in sequence=%b", req.rate_limiter_16to4_rstn);
      `uvm_info(get_type_name(), "reset scenario 1 is completed", UVM_LOW);
      
      // Send a final transaction to properly terminate the sequence
      start_item(req);
      req.rate_limiter_16to4_rstn = 1'b1; // Deassert reset to finish sequence
      finish_item(req);
    end

    if(scenario == 2) begin
      // First, deassert reset
      `uvm_do_with(req, {
        req.rate_limiter_16to4_rstn == 1;
        // Keep all other signals at their default values
      });

      // Configure OUT_STREAM_0_REG
      start_item(req);
      req.sch_reg_wr_en   = 1'b1;
      req.sch_reg_wr_addr = 5'd0; // OUT_STREAM_0_REG
      req.sch_reg_wr_data = 64'h0000_0000_0000_0001; // Input stream 0 mapped
      finish_item(req);

      // Configure IN_STREAM_0_REG
      start_item(req);
      req.sch_reg_wr_en   = 1'b1;
      req.sch_reg_wr_addr = 5'd4; // IN_STREAM_0_REG
      req.sch_reg_wr_data = {49'd1, 15'd0}; // 1 packet, token wait 0
      finish_item(req);

      // Send start of packet on stream 0
      start_item(req);
      req.pck_str_empty_0 = 1'b0; // Non-empty packet for stream 0
      req.in_sop_0        = 1'b1; // Start of packet
      req.in_stream_0     = 64'h1234_5678_DEAD_BEEF; // Packet data
      req.in_eop_0        = 1'b0; // Not end of packet yet
      finish_item(req);

      // Complete packet transmission with end of packet
      start_item(req);
      req.pck_str_empty_0 = 1'b0;
      req.in_sop_0        = 1'b0; // Not start
      req.in_stream_0     = 64'h0; // Could be different data if needed
      req.in_eop_0        = 1'b1; // End of packet
      finish_item(req);
      
      // Reset signals after packet transmission
      start_item(req);
      req.pck_str_empty_0 = 1'b1; // Empty again
      req.in_sop_0        = 1'b0;
      req.in_stream_0     = 64'h0;
      req.in_eop_0        = 1'b0;
      finish_item(req);

      `uvm_info("ULSS", $sformatf("Stream 0 packet sent"), UVM_LOW)
      `uvm_info(get_type_name(), "Starting ULSS Sequence for Stream 0 Only", UVM_MEDIUM)   
      $display("Reset signal is successfully generated in sequence=%b", req.rate_limiter_16to4_rstn);
    end
    
    // Add delay to ensure all transactions are processed
    #10;
  endtask
endclass
