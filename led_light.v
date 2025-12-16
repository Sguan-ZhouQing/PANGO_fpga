`timescale 1ns / 1ps  
`define UD #1  

module led_light(  
    input          clk,  
    input          rstn,  
    output [7:0]   led  
);  

//==================================================================  
//reg and wire  

    reg [25:0] led_light_cnt    = 26'd0         ;  
    reg [ 7:0] led_status       = 8'b0000_0000  ;  

//time counter  
    always @(posedge clk)  
    begin  
        if(!rstn)  
            led_light_cnt <= `UD 26'd0;  
        else if(led_light_cnt == 26'd24_999_999)  
            led_light_cnt <= `UD 26'd0;  
        else  
            led_light_cnt <= `UD led_light_cnt + 26'd1;   
    end  

//led status change  
    always @(posedge clk)  
    begin  
        if(!rstn)  
            led_status <= `UD 8'b0000_0000;  
        else if(led_light_cnt == 26'd24_999_999)  
            led_status <= `UD ~led_status;  
    end  

    assign led = led_status;  

endmodule