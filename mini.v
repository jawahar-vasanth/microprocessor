`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:39 10/12/2017 
// Design Name: 
// Module Name:    mini 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
/////////////////////////////////////////////////////////////////////////////////
//								Cheatsheet
//OpCode						Process
//0000							ADD R1,R2,R3	(adds R2 to R1 and stores it in R3)
//0001							SUB R1,R2,R3	(subracts R2 from R1 and stores it in R3)
//0010							AND R1,R2,R3	(bitwise and on R1,R2 and stores in R3)
//0011							OR R1,R2,R3		(bitwise or on R1,R2 and stores in R3)
//0100							LS R1,R2,R3		(left shifts R1 by R2 unit and stores in R3)
//0101							RS R1,R2,R3		(right shifts R1 by R2 unit and stores in R3)
//0110							INC R1			(increments by 1 value)
//0111							DEC R1			(decrements by 1 value)
//1000							MOV R5,R3 		(moves data from R5 to R3)
//1001							LD R5,0xf 		(loads R5 with data)
//1010							ST R5,M1 		(stores R5 onto external memory address)
//1011							LDI R5,M3  		(loads onto R5 from memory address)
//1100							STI M3,0xf		(stores the data immediately)
//1101							BNE C1 C2		(branches to C1 if zero flag is present else to C2)
//1110							BREC C1 C2		(branches to C1 if carry flag is present else to C2)
//1111							STOP			(stops the program)
// Flags[overflow/underflow,zero]
/////////////////////////////////////////////////////////////////////////////////


module mini(clk,L,W,R,S);
wire[3:0] adrs;
wire[7:0] dtin,dm1,dm2;
wire[2:0] cbus;
wire[1:0] flag;
output wire W,R,L,S;
input wire clk;
wire[7:0] out;
reg[7:0] ram[0:15];
reg[7:0] bus;
assign dm1=ram[3];							//Just to check whether store is working
assign dm2=ram[4];
cu ControlUnit(clk,adrs,dtin,W,R,cbus,L,S,flag);
eu ExecutionUnit(adrs,dtin,W,R,cbus,L,out,S,bus,flag);

always@(*) begin
if (L&S) begin
	bus<=ram[adrs];
	end
if(W&S) begin
	ram[adrs]=out;
	end
end
endmodule



module cu(clk,adrs,dtin,W,R,cbus,L,S,flag);
input wire clk;
output wire[3:0] adrs;
output wire[7:0] dtin;
output wire[2:0] cbus;
input wire[1:0] flag;
output wire W,R,L,S;
wire[4:0] pc;
wire [4:0] countadd;
wire [15:0] instruc;
wire count;

counter ProgramCounter(clk,count,pc,countadd);
instrucrdec InstructionDecoder(instruc,clk,adrs,dtin,W,R,cbus,L,S,count,flag,countadd);
progmemory ProgramMemory(clk,pc,instruc);

endmodule

module counter(clk,count,pc,countadd);
input wire clk,count;
output reg[4:0] pc;
input wire [4:0] countadd;
initial begin 
pc=0;
end
always@(posedge(count))begin
	if(countadd==5'b11111) begin
		pc=pc+1;
		end
	else begin
		pc=countadd;
		end
	end
endmodule

module progmemory(clk,pc,instruc);
reg[15:0] pmem[0:31];
output reg[15:0] instruc;
input wire [4:0] pc;
input wire clk;
initial begin
	pmem[0]= 16'b1001_0110_00000111;   //LD R6,8b'00000100;  Factorial of 5
    pmem[1]= 16'b1001_0111_00000010;   //LD R7,8b'00000010;
    pmem[2]= 16'b1001_1000_00000000;   //LD R8,8b'00000000;
    pmem[3]= 16'b1000_0110_0100_xxxx;  //MOV R6, R4;
    pmem[4]= 16'b0001_0100_0111_0100;  //SUB R4, R7,R4;
    pmem[5]= 16'b1000_0110_0011_xxxx;  //MOV R6,R3
    pmem[6]= 16'b1000_1000_1001_xxxx;  //MOV R8,R9
    pmem[7]= 16'b1000_0100_0101_xxxx;  //MOV R4, R5; 
	pmem[8]= 16'b0000_1000_1001_1000; //ADD R8, R9, R8;       
    pmem[9]= 16'b0000_0110_0011_0110;  //ADD R6, R3, R6;
    pmem[10]= 16'b1110_01011_01100_xx;  //BREC 11,12 ;
    pmem[11]= 16'b0110_1000_xxxxxxxx; //INC R8;
    pmem[12]= 16'b0111_0101_xxxxxxxx; //DEC R5;
    pmem[13]= 16'b1101_01110_01000_xx; //BNE 14,8;                   
    pmem[14]= 16'b0111_0100_xxxxxxxx; //DEC R4;
    pmem[15]= 16'b1101_10000_00101_xx; //BNE 16,5;
    pmem[16]= 16'b1010_0110_0011_xxxx; //ST R6,M3;  
    pmem[17]= 16'b1010_1000_0100_xxxx; //ST R8,M4;                                       
    pmem[18]= 16'b1111_xxxxxxxxxxxx;   //STOP 
	
	// pmem[0]= 16'b1001_0110_00000101;  //LD R6,8b'00000100;  Factorial of 5
	// pmem[1]= 16'b1001_0111_00000010;  //LD R7,8b'00000010;
    // pmem[2]= 16'b1000_0110_0100_xxxx;  //MOV R6, R4;
    // pmem[3]= 16'b0001_0100_0111_0100;  //SUB R4, R7,R4;
    // pmem[4]= 16'b1000_0110_0011_xxxx;  //MOV R6,R3
    // pmem[5]= 16'b1000_0100_0101_0001;  //MOV R4, R5;        
    // pmem[6]= 16'b0000_0110_0011_0110;//ADD R6, R3, R6; 
    // pmem[7]= 16'b0111_0101_xxxxxxxx;//DEC R5;
    // pmem[8]= 16'b1101_01001_00110_xx;//BNE 9,6;                   
    // pmem[9]= 16'b0111_0100_xxxxxxxx;//DEC R4
    // pmem[10]= 16'b1101_01011_00100_xx;//BNE 11,4;
    // pmem[11]= 16'b1010_0110_0011_xxxx;//ST R6,M3;     
    // pmem[12]= 16'b1111_xxxxxxxxxxxx;//STOP   
end
always@(*)begin
 instruc=pmem[pc];
end 
endmodule

module instrucrdec(instruc,clk,adrs,dtin,W,R,cbus,L,S,count,flag,countadd);
input wire clk;
input wire[1:0] flag;
output reg[3:0] adrs;
output reg count;
output reg[2:0] cbus;
output reg W,R,L,S;
output reg[4:0] countadd;
reg wr,re,ld;
reg[3:0] addr;
output reg [7:0] dtin;
reg [7:0] d_in;
input wire[15:0] instruc;
reg[3:0] start,a,b,c,d,e,f,g,st;
initial begin		//Assigning all possible states in 3 bit
count=0;
start=3'b000;
a=3'b001;
b=3'b010;
c=3'b011;
d=3'b100;
e=3'b101;
f=3'b110;
g=3'b111;
st=start;
countadd=5'b11111;
end
always@(posedge clk)begin
	
	if(st==f)
	st=g;
	if(st==e)
	st=f;
	if(st==d)
	st=e;
	if(st==c)
	st=d;
	if(st==b)
	st=c;
	if(st==a)
	st=b;
	if(st==start)	begin
	st=a;
	count=0;
	countadd=5'b11111;
	end

	if(instruc[15]==1'b0) begin			//ALU Operations
	if(st==a) begin
	W=0;
	R=1;
	adrs = instruc[11:8];
	end
	if(st==b) begin
	W=1;
	R=0;
	adrs = 4'b0000;
	end
	if(st==c) begin
	W=0;
	R=1;
	adrs = instruc[7:4];
	end
	if(st==d) begin
	W=1;
	R=0;
	adrs = 4'b001;
	end
	if(st==e) begin
	W=0;
	cbus = instruc[14:12];
	end
	if(st==f) begin
	R=1;
	adrs= 4'b0010;
	end	
	if(st==g) begin
	R=0;
	W=1;
	if(instruc[14]==1'b0|instruc[14:13]==2'b10)begin
	adrs= instruc[3:0];
	end
	else if(instruc[14:13]==2'b11)begin
	adrs= instruc[11:8];
	end
	count=1;
	st=start;
	end
	end
	
	
	case(instruc[15:12])
	4'b1000:								//Move
	begin
	if(st==a) begin
	adrs=instruc[11:8];
	R=1;
	W=0;
	end
	if(st==b) begin
	adrs=instruc[7:4];
	R=0;
	W=1;
	end
	if(st==c) begin
	st=start;
	count=1;
	W=0;
	end
	end

	4'b1001:						//Load
	begin
	if(st==a) begin
	adrs=instruc[11:8];
	dtin=instruc[7:0];
	R=0;
	W=0;
	L=1;
	S=0;
	end
	if(st==b) begin
	W=1;
	L=0;
	end
	if(st==c) begin
	W=0;
	count=1;
	st=start;
	end
	end

	4'b1010:						//Store
	begin
	if(st==a) begin
	adrs=instruc[11:8];
	R=1;
	W=0;
	L=0;
	S=1;
	end
	if(st==b) begin
	adrs=instruc[7:4];
	R=0;
	W=1;
	S=1;
	end
	if(st==c) begin
	st=start;
	S=0;
	count=1;
	W=0;
	end 
	end

	4'b1011:						//Load from external memory
	begin
	if(st==a) begin
	adrs=instruc[7:4];
	R=0;
	W=0;
	L=1;
	S=1;
	end
	if(st==b) begin
	adrs=instruc[11:8];
	L=0;
	W=1;
	S=0;
	end
	if(st==c) begin
	W=0;
	count=1;
	st=start;
	end
	end

	4'b1111: begin				//Stop
	st=g;
	end

	4'b1101:begin
	if(st==a)begin
	if(flag[0]==1'b1) begin
	countadd=instruc[11:7];
	end
	else begin
	countadd=instruc[6:2];
	end
	end
	if(st==b) begin
	count=1;
	st=start;
	end
	end

	4'b1110:begin
	if(st==a)begin
	if(flag[1]==1'b1) begin
	countadd=instruc[11:7];
	end
	else begin
	countadd=instruc[6:2];
	end
	end
	if(st==b) begin
	count=1;
	st=start;
	end
	end

	4'b1100:						//Store immedieately
	begin
	if(st==a) begin
	dtin=instruc[7:0];
	adrs=4'b0000;
	R=0;
	W=0;
	L=1;
	S=0;
	end
	if(st==b) begin
	L=0;
	W=1;
	end
	if(st==c) begin
	R=1;
	S=1;
	W=0;
	end
	if(st==d) begin
	adrs=instruc[11:8];
	R=0;
	W=1;
	S=1;
	L=0;
	end
	if(st==e) begin
	st=start;
	S=0;
	count=1;
	W=0;
	end 
	end

	

	endcase
	end

endmodule

module eu(adrs,dtin,W,R,cbus,L,out,S,bust,flag);
input wire[3:0] adrs;
input wire[7:0] dtin,bust;
input wire[2:0] cbus;
input W,R, L, S;
output reg[7:0] out ;
output reg[1:0] flag;
wire [7:0] a1, a2,a3,test1,test2,test3,test4,test5,test6,test7;
reg[7:0] mem [0:15];
reg[7:0] bus;
reg [3:0] addbus;
wire [1:0] f;

	always @(*) begin
		if(1) begin
			addbus <= adrs;
		end
		if(L&!S) begin
			bus <= dtin;
		end
		if(W &!S) begin
			mem[addbus] = bus;
		end
		if (R &!S) begin
			bus = mem[addbus];
		end
		if (R & S) begin
			out= mem[addbus];
		end
		if(L&S) begin
			bus<=bust;
		end
		
	end
assign a1 = mem[0];					//Hard coding the registers to perform the operation 
assign a2 = mem[1];

alu ArithmeticLogicUnit(a1, a2, a3, cbus,f);

always @(*) begin
	mem[2] <= a3;
	flag<=f;
end
assign test1=mem[3];	
assign test2=mem[4];
assign test3=mem[5];
assign test4=mem[6];
assign test5=mem[7];
assign test6=mem[8];
assign test7=mem[9];
assign test8=mem[10];
endmodule


module alu(a1,a2,a3,cbus,flag);
input [2:0] cbus;
input [7:0] a1,a2;
output [7:0] a3;
output [1:0] flag;
reg [8:0] res;
wire [7:0] temp;
reg [1:0] f;
assign temp =8'b00000001;
always @(*)begin
case(cbus)
	3'b000 :begin
	 res=a1+a2;
	 f[1]=res[8];
	 if(res==0) begin
		f[0]=1'b1;
		end
	else begin
		f[0]=1'b0;
		end
	end
	3'b001 :begin
	 res=a1-a2;
	 f[1]=res[8];
	 if(res==0) begin
		f[0]=1'b1;
		end
	else begin
		f[0]=1'b0;
		end
	end
	3'b010 :begin
	 res=a1&a2;
	 f[1]=res[8];
	 if(res==0) begin
		f[0]=1'b1;
		end
	else begin
		f[0]=1'b0;
		end
	end
	3'b011 :begin
	 res=a1|a2;
	 f[1]=res[8];
	 if(res==0) begin
		f[0]=1'b1;
		end
	else begin
		f[0]=1'b0;
		end
	end
	3'b100 :begin
	 res=a1<<a2;
	 f[1]=res[8];
	 if(res==0) begin
		f[0]=1'b1;
		end
	else begin
		f[0]=1'b0;
		end
	end
	3'b101 : begin
	 res=a1>>a2;
	 f[1]=res[8];
	 if(res==0) begin
		f[0]=1'b1;
		end
	else begin
		f[0]=1'b0;
		end
	end
	3'b110 :begin
	 res=a1+temp;
	 f[1]=res[8];
	 if(res==0) begin
		f[0]=1'b1;
		end
	else begin
		f[0]=1'b0;
		end
	end
	3'b111 :begin
	 res=a1-temp;
	 f[1]=res[8];
	 if(res==0) begin
		f[0]=1'b1;
		end
	else begin
		f[0]=1'b0;
		end
	end 
	default res=a3 ;
	endcase	
end
assign a3=res[7:0];
assign flag=f;
endmodule
