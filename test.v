
module test;
   reg R,L,rst,clk;
   wire TL,TR,F ;


FSM5state dut(R,L,rst,clk, TL,TR,F );

initial
  begin
   clk = 0;
    forever #5 clk = ~clk;
  end

initial
 begin
   rst = 0;
   @(negedge clk); #1 rst =1;
   @(negedge clk); L = 0; R = 0;
   #20;
   @(negedge clk); L = 1; R = 0;
   #20;
   @(negedge clk); L = 0; R = 1;
   #20;
   @(negedge clk); L = 0; R = 0;
   #20;
   @(negedge clk); L = 1; R = 0;
   #20;
   @(negedge clk); L = 1; R = 1;
   #20;
   @(negedge clk); L = 0; R = 0;
   #20;
   @(negedge clk); L = 1; R = 0;
   #20;
   $finish;
  end




initial
 begin
 $dumpfile("roboant.vcd");
 $dumpvars;
end
endmodule

      