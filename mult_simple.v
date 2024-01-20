`timescale 1ns / 1ps
        
module mult_simple
    #( parameter WIDTH = 5)
    
    (
    input iclk,
    input [WIDTH - 1 : 0] ia,
    input [WIDTH - 1 : 0] ib,
    output [WIDTH*2 - 1 : 0] ores,
    input istart,
    output ovalid,
    output oready
    );
    
    reg [WIDTH - 1 : 0] a;
    reg [WIDTH - 1 : 0] b;
    reg [WIDTH*2 - 1 : 0] ans;
    
    reg valid;
    reg ready;
    
    always @(posedge iclk)
    begin
        if (istart)
        begin
            a <= ia;
            b <= ib;
            ready <= 0;
        end
        
        if (valid) 
        begin
            ready <=1;
        end
        
        valid <= istart;    
        
        ans = a * b;        
    end
    
    assign ovalid = valid;
    assign oready = ready;
    assign ores = ans;
endmodule
