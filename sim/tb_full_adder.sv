`timescale 1ns/1ps

module tb_full_adder_modern;

    reg a, b, cin;
    wire sum, cout;

    full_adder dut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    integer n;
    integer checked = 0;
    reg [1:0] expected;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_full_adder_modern);

        for (n = 0; n < 8; n = n + 1) begin
            {a, b, cin} = n;

            expected = a + b + cin;

            #10;

            if ({cout, sum} !== expected)
                $fatal(1,
                    "FAIL full_adder vector=%0d expected=%b actual=%b",
                    n, expected, {cout, sum});

            checked = checked + 1;
        end

        if (checked != 8)
            $fatal(1, "Incomplete test");

        $display("LAB1_PASS full_adder cases=%0d", checked);

        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "watchdog");
    end

endmodule