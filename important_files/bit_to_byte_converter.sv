module bit_to_byte_converter (
  input logic in_bit,
  output logic [7:0] out_byte
);

always_comb begin
  out_byte = in_bit ? 8'hFF : 8'h00;
end

endmodule