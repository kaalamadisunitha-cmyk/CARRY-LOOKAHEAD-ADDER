`timescale 1ns/1ps

module carry_lookahead_adder_tb;

    reg  [3:0] a;
    reg  [3:0] b;
    reg        cin;

    wire [3:0] sum;
    wire       cout;

    integer i;
    integer errors;
    reg [4:0] expected;

    carry_lookahead_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin

        $dumpfile("simulation/waveform.vcd");
        $dumpvars(0, carry_lookahead_adder_tb);

        errors = 0;

        $display("==============================================");
        $display("       4-BIT CARRY LOOK-AHEAD ADDER");
        $display("              TESTBENCH");
        $display("==============================================");

        // Test all combinations
        for (i = 0; i < 512; i = i + 1) begin

            a   = i[7:4];
            b   = i[3:0];
            cin = i[8];

            #10;

            expected = a + b + cin;

            if ({cout, sum} !== expected) begin

                $display(
                    "FAIL: A=%b B=%b Cin=%b -> Sum=%b Cout=%b Expected=%b",
                    a, b, cin, sum, cout, expected
                );

                errors = errors + 1;

            end
        end

        $display("----------------------------------------------");

        if (errors == 0)
            $display("RESULT: ALL 512 TESTS PASSED");
        else
            $display("RESULT: %0d TESTS FAILED", errors);

        $display("==============================================");

        $finish;

    end

endmodule