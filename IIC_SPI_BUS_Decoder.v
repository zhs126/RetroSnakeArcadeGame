module IIC_SPI_BUS_Decoder(
input unsigned [31:0] Address,
input IOSelect,
input AS_L,
output reg IIC0_Enable_H
);

	always@(*) begin

		IIC0_Enable_H <= 0;
		if(Address[23:4] == 20'b0100_0000_1000_0000_0000 && AS_L == 0 && IOSelect == 1) begin	
		SPI_Enable_H <= 1 ;	end
		
	end
endmodule
	      