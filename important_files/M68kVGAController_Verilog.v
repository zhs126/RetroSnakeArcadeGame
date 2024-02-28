module M68kVGAController_Verilog(
			input Clock,							// used to drive the state machine- stat changes occur on positive edge
			input Reset_L,     						// active low reset 
			input CPU_Enable, 
			input [11:0] Address,
			input [7:0] Data,			
			output reg [7:0] ocrx,
			output reg [7:0] ocry,
			output reg [7:0] octl,
			output reg WEA,
			output reg WEB,
			output reg VGABLANKING_L,
			output reg [7:0] dataB
		); 	

reg  [2:0] Command;							    // 3 bit signal containing ram_weA, ram_weB, VGABLANKING_L
reg  [7:0] RAM_DATin_B;
reg  [7:0] CRX;
reg  [7:0] CRY;
reg  [7:0] CTL;
reg  [4:0] CurrentState;					
reg  [4:0] NextState;						// holds the next state of the dram controller

//state
parameter Initial = 5'h00;				// power on initialising state
parameter CTL_update = 5'h01;				
parameter CRX_update = 5'h02;				
parameter CRY_update = 5'h03;	

//param			
parameter NOP = 3'b001; 
parameter DATA_0 = 1'b0; 
parameter ADDRESS_0 = 12'b0; 
parameter CRX_Init = 8'h28;
parameter CRY_Init = 8'h14;
parameter CTL_Init = 8'hf5;

always@(posedge Clock, negedge Reset_L)
	begin
		if(Reset_L == 0) 			
			CurrentState <= Initial ;

		else 	begin								// state can change only on low-to-high transition of clock
			CurrentState <= NextState;		
			ocrx <= CRX;
			ocry <= CRY;
			octl <= CTL;
			WEA <= Command[2];			// RAM WE A
			WEB <= Command[1];			// RAM WE B
			VGABLANKING_L  <= Command[0];	//VGABLANKING
			dataB  <= RAM_DATin_B;		
		end
	end	

always@(*)begin
		NextState <= Initial;		

		Command <= NOP;							    // 3 bit signal containing ram_weA, ram_weB, VGABLANKING_L
		RAM_DATin_B <= DATA_0;
		CRX <= CRX_Init;
		CRY <= CRY_Init;
		CTL <= CTL_Init;			

		if(CurrentState == Initial) begin
			CTL <= CTL; 
			CRY <= CRY; 
			CRX <= CRX; 
			case({Address,CPU_Enable})
				13'b1111_0000_0000_1 : NextState <= CTL_update;
				13'b1111_0000_0010_1 : NextState <= CRX_update;
				13'b1111_0000_0100_1 : NextState <= CRY_update;
				default : NextState <= Initial;
			endcase
		end
				
		else if(CurrentState <= CTL_update)begin
			CTL <= Data; 
			CRY <= CRY; 
			CRX <= CRX; 
			NextState <= Initial; 
		end 
		
		else if(CurrentState <= CRX_update)begin
			CTL <= CTL; 
			CRY <= CRY; 
			CRX <= Data; 
			NextState <= Initial; 
		end 
		
		else if(CurrentState <= CRY_update)begin
			CTL <= CTL; 
			CRY <= Data; 
			CRX <= CRX; 
			NextState <= Initial; 
		end 
		

		
		else begin	
			CTL <= CTL; 
			CRY <= CRY; 
			CRX <= CRX; 
			NextState <= Initial;	
		end	
end
endmodule
