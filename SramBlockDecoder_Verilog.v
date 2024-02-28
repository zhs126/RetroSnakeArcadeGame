/*
module SramBlockDecoder_Verilog( 
		input unsigned [16:0] Address, // lower 17 lines of address bus from 68k
		input SRamSelect_H,				 // from main (top level) address decoder indicating 68k is talking to Sram
		
		// 4 separate block select signals that parition 256kbytes (128k words) into 4 blocks of 64k (32 k words)
		output reg Block0_H, 
		output reg Block1_H, 
		output reg Block2_H, 
		output reg Block3_H
);	

	always@(*)	begin

		// default block selects are inactive - override as appropriate later
		if(SRamSelect_H == 1'b1 && Address <= 17'b0_0000_0000_0000)begin
		end else if (SRamSelect_H == 1'b1 && Address <= 17'b0_0111_1111_1110) begin 
		{Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b0111;
		end else if (SRamSelect_H == 1'b1 && Address <= 17'b0_1111_1111_1110) begin 
		{Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b1011;
		end else if (SRamSelect_H == 1'b1 && Address <= 17'b1_0111_1111_1110) begin 
		{Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b1101;
		end else if (SRamSelect_H == 1'b1 && Address <= 17'b1_1111_1111_1110) begin 
		{Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b1110;
		end else begin
		{Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b1111;
		end 
		// decode the top two address lines plus SRamSelect to provide 4 block select signals
		// for 4 blocks of 64k bytes (32k words) to give 256k bytes in total
		// TODO
		
	end
endmodule
*/
module SramBlockDecoder_Verilog( 
		input unsigned [16:0] Address, // lower 17 lines of address bus from 68k
		input SRamSelect_H,				 // from main (top level) address decoder indicating 68k is talking to Sram
		
		// 4 separate block select signals that parition 256kbytes (128k words) into 4 blocks of 64k (32 k words)
		output reg Block0_H, 
		output reg Block1_H, 
		output reg Block2_H, 
		output reg Block3_H 
);	

	always@(*)	begin
		case({Address[16:15],SRamSelect_H})
		// default block selects are inactive - override as appropriate later
		3'b001: {Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b0111; 
		3'b011: {Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b1011; 
		3'b101: {Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b1101; 
		3'b111: {Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b1110; 
		default:  {Block0_H,Block1_H,Block2_H,Block3_H} <= 4'b1111; 
		// decode the top two address lines plus SRamSelect to provide 4 block select signals
		// for 4 blocks of 64k bytes (32k words) to give 256k bytes in total
		// TODO
		endcase
	end
endmodule
