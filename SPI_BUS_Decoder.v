

module SPI_BUS_Decoder (
	input unsigned [31:0] Address,
	input IOSelect,
	input AS_L,

	output reg IIC0_Enable_H
);

always@(*) begin

	IIC0_Enable_H <= 1'b0;
	if(Address[15:4] == 12'b1000_0000_0000 && AS_L == 0 && IOSelect == 1) begin 
		IIC0_Enable_H <= 1'b1;
	end
end
endmodule