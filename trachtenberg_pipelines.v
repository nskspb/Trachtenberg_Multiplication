///Умножение Трахтенберга распаралеленное
///
/// Решение неверно!   

`timescale 1ns / 1ps

module trachtenberg_pipelines
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
    reg [WIDTH*2 - 1 : 0] ans0, ans1, ans2, ans3, ans4, ans5, ans6, ans7, ans8;
    
    reg valid;
    reg ready;
    
    always @(posedge iclk)
    begin
        res0 <= a[0] & b[0];
        ans0[0] <= res0[0];
        ans1 <= ans0;
        
        res1 <= (a[0] & b[1]) + (a[1] & b[0]);
        ans1[1] <= res1[0];
        ans2 <= ans1;
        
        res2 <= (a[0] & b[2]) + (a[2] & b[0]) + (a[1] & b[1]) + res1[9:1];
        ans2[2] <= res2[0];
        ans3 <= ans2;
        
        res3 <= (a[0] & b[3]) + (a[3] & b[0]) + (a[2] & b[1]) + (a[1] & b[2]) + res2[9:1];
        ans3[3] <= res3[0];
        ans4 <= ans3;
        
        res4 <= (a[0] & b[4]) + (a[4] & b[0]) + (a[1] & b[3]) + (a[3] & b[1]) + (a[2] & b[2]) + res3[9:1];
        ans4[4] <= res4[0];
        ans5 <= ans4;
        
        res5 <= (a[1] & b[4]) + (a[4] & b[1]) + (a[2] & b[3]) + (a[3] & b[2]) + res4[9:1];
        ans5[5] <= res5[0];
        ans6 <= ans5;
        
        res6 <= (a[2] & b[4]) + (a[4] & b[2]) + (a[3] & b[3]) + res5[9:1];
        ans6[6] <= res6[0];
        ans7 <= ans6;
        
        res7 <= (a[3] & b[4]) + (a[4] & b[3]) + res6[9:1];
        ans7[7] <= res7[0];
        ans8 <= ans7;
        
        res8 <= (a[4] & b[4]) + res7[9:1];
        ans8[9:8] <= res8[1:0];
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
    assign ores = ans8;
    
endmodule

