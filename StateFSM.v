`timescale 1ns/1ns

module FSM5state(
    input R,L,rst,clk,
    output reg TL,TR,F );

   localparam LOST = 2'D0, 
              RCCW =2'D1, 
              Wall1=2'd2,
              Wall2=2'd3;
              
 
   reg [1:0]next_state,present_state ;

   always @(posedge clk)
     begin
      if(!rst)
        present_state <= LOST;
      else
        present_state <= next_state;
      end

   always @(*)
      begin
        case(present_state)
          LOST : begin
                   if((!L) & (!R)) 
                     next_state = LOST;
                  else if(L | R)
                    next_state = RCCW; end

          RCCW : begin 
                   if((!L) & (!R)) 
                     next_state = Wall1;
                  else if(L | R)
                    next_state = RCCW; end
         Wall1 : begin
                   if(R) 
                     next_state = Wall2;
                  else
                    next_state = Wall1; end

         Wall2 : begin
                   if((!L) & (R)) 
                     next_state = Wall2;
                  else if((!L) & (!R)) 
                    next_state = Wall1;
                 else 
                   next_state = RCCW;  end

      default: next_state = LOST;
     endcase
  end

 always @(present_state)
   begin
     case(present_state)
       
     LOST: begin
             TL = 1'b0;
             TR = 1'b0;
              F = 1'b1; end
    
     RCCW: begin
             TL = 1'b1;
             TR = 1'b0;
              F = 1'b0; end

       Wall1: begin
             TL = 1'b0;
             TR = 1'b1;
              F = 1'b1; end
  
      Wall2: begin
             TL = 1'b1;
             TR = 1'b0;
              F = 1'b1; end
   default: begin
             TL = 1'b0;
             TR = 1'b0;
              F = 1'b1; end
   endcase
   end
 endmodule
   
