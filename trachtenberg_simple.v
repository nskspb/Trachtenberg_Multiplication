//
// Обычное умножение Трахтенберга 
//

`timescale 1ns / 1ps
       
module trachtenberg_simple
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
    reg [WIDTH*2 - 1 : 0] res0, res1, res2, res3, res4, res5, res6, res7, res8;
    reg [WIDTH*2 - 1 : 0] ans;
    
    reg valid;
    reg ready;
    
    always @(posedge iclk)
    begin
        res0 = a[0] & b[0];
        ans[0] = res0[0];
        
        res1 = (a[0] & b[1]) + (a[1] & b[0]);
        ans[1] = res1[0];
        
        res2 = (a[0] & b[2]) + (a[2] & b[0]) + (a[1] & b[1]) + res1[9:1];
        ans[2] = res2[0];
        
        res3 = (a[0] & b[3]) + (a[3] & b[0]) + (a[2] & b[1]) + (a[1] & b[2]) + res2[9:1];
        ans[3] = res3[0];
        
        res4 = (a[0] & b[4]) + (a[4] & b[0]) + (a[1] & b[3]) + (a[3] & b[1]) + (a[2] & b[2]) + res3[9:1];
        ans[4] = res4[0];
        
        res5 = (a[1] & b[4]) + (a[4] & b[1]) + (a[2] & b[3]) + (a[3] & b[2]) + res4[9:1];
        ans[5] = res5[0];
        
        res6 = (a[2] & b[4]) + (a[4] & b[2]) + (a[3] & b[3]) + res5[9:1];
        ans[6] = res6[0];
        
        res7 = (a[3] & b[4]) + (a[4] & b[3]) + res6[9:1];
        ans[7] = res7[0];
        
        res8 = (a[4] & b[4]) + res7[9:1];
        ans[9:8] = res8[1:0];
    end
    
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
    end
    
    assign ovalid = valid;
    assign oready = ready;
    assign ores = ans;
    
endmodule
