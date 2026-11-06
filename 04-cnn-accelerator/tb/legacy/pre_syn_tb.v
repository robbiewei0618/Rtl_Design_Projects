`timescale 1ns / 1ns
`define period                  10
`define img_max_size            224*224*3+54
`define padding_img_size        226*226
`define weight_1_size           9*3*64
`define weight_2_size           9*64*64
`define bias_size               64
`define weight_1_input_size     9*3
`define weight_2_input_size     9*4

//---------------------------------------------------------------
//You need specify the path of image in/out
//---------------------------------------------------------------
`define path_img_in      "/home/B105040024_HDL/HW5/cat224.bmp"
`define conv1_weight     "/home/B105040024_HDL/HW5/conv1_kernel_hex.txt"
`define conv1_bias       "/home/B105040024_HDL/HW5/conv1_bias_hex.txt"
`define conv2_weight     "/home/B105040024_HDL/HW5/conv2_kernel_hex.txt"
`define conv2_bias       "/home/B105040024_HDL/HW5/conv2_bias_hex.txt"
`define IMG_PATH_BASE_1    "/home/B105040024_HDL/HW5/out_layer1/cat_"
`define IMG_PATH_BASE_2    "/home/B105040024_HDL/HW5/out_layer2/cat_"

module HDL_HW5_TB;
    integer img_in, img_out_1, img_out_2, img_out_3, img_out_4;
    integer weight_1, status_1, bias_1, status_11;
    integer weight_2, status_2, bias_2, status_22;
    integer offset, img_h, img_w, header;
    integer count;
    integer idx, jdx, img_idx; 
    integer h, w;

    reg         clk, rst, sel, sel2;
    wire        en;
    reg  [7:0]  img_data [0:`img_max_size-1];               // input bmp
    reg  signed [15:0]  weight_1_data [0:`weight_1_size-1]; // input weight 1 
    reg  signed [15:0]  bias_1_data [0:`bias_size-1];       // input bias 1 
    reg  signed [15:0]  weight_2_data [0:`weight_2_size-1]; // input weight 2
    reg  signed [15:0]  bias_2_data [0:`bias_size-1];       // input bias 2
    reg  [7:0]  padding_img [2:0][0:`padding_img_size-1];   // padding R,G,B
    reg  [7:0]  padding_img_after_layer1 [63:0][0:`padding_img_size-1]; // padding data after layer 1
    reg  [255*8:1]  img_path_1, img_path_2, img_path_3, img_path_4; // output file path
    reg  signed [8:0]  pixel_1, pixel_2, pixel_3, pixel_4;  // layer 1 RBG
    wire [7:0]  out_1, out_2, out_3, out_4; 
    reg signed [9*4*16-1:0]  input_weight_1, input_weight_2, input_weight_3, input_weight_4;
    reg signed [15:0]       input_bias_1, input_bias_2, input_bias_3, input_bias_4;

    //---------------------------------------------------------------
    //Insert your verilog module at here
    //
    layer_1 L1 (clk, rst, sel, sel2, en, pixel_1, pixel_2, pixel_3, pixel_4, 
                input_weight_1, input_weight_2, input_weight_3, input_weight_4, 
                input_bias_1, input_bias_2, input_bias_3, input_bias_4,
                out_1, out_2, out_3, out_4);
    //
    //---------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------------------------------------------------
    //---------------------------------------------------------------
    //This initial block read the pixel 
    //---------------------------------------------------------------
    initial begin
        // open input files
        img_in  = $fopen(`path_img_in, "rb");
        bias_1  = $fopen(`conv1_bias, "r");
        weight_1  = $fopen(`conv1_weight, "r");
        bias_2  = $fopen(`conv2_bias, "r");
        weight_2  = $fopen(`conv2_weight, "r");

        // read input files
        $fread(img_data, img_in);
        idx = 0;
        while (!$feof(weight_1)) begin
            status_1 = $fscanf(weight_1, "%h\n", weight_1_data[idx]);
            if (status_1 == 1) idx = idx + 1;
        end
        idx = 0;
        while (!$feof(bias_1)) begin
            status_11 = $fscanf(bias_1, "%h\n", bias_1_data[idx]);
            if (status_11 == 1) idx = idx + 1;
        end
        idx = 0;
        while (!$feof(weight_2)) begin
            status_2 = $fscanf(weight_2, "%h\n", weight_2_data[idx]);
            if (status_2 == 1) idx = idx + 1;
        end
        idx = 0;
        while (!$feof(bias_2)) begin
            status_22 = $fscanf(bias_2, "%h\n", bias_2_data[idx]);
            if (status_22 == 1) idx = idx + 1;
        end

        // read header information of input file
        img_w   = {img_data[21],img_data[20],img_data[19],img_data[18]};
        img_h   = {img_data[25],img_data[24],img_data[23],img_data[22]};
        offset  = {img_data[13],img_data[12],img_data[11],img_data[10]};

        // zero padding of read image
        for(idx = 0; idx<`padding_img_size; idx = idx+1) begin
            for(jdx = 0; jdx < 3; jdx = jdx+1) begin
                padding_img[jdx][idx] = 0;
            end
        end
        for(idx = 0; idx<`padding_img_size; idx = idx+1) begin
            for(jdx = 0; jdx < 64; jdx = jdx+1) begin
                padding_img_after_layer1[jdx][idx] = 0;
            end
        end

        for(h = 0; h < img_h; h = h+1) begin
            for(w = 0; w < img_w; w = w+1) begin
                padding_img[2][h*226+w+227] = img_data[(h*224+w)*3 + offset + 2];
                padding_img[1][h*226+w+227] = img_data[(h*224+w)*3 + offset + 1];
                padding_img[0][h*226+w+227] = img_data[(h*224+w)*3 + offset + 0];
            end
        end
        $fclose(img_in);
    end
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //---------------------------------------------------------------
    //This initial block write the pixel 
    //---------------------------------------------------------------
    initial begin
        clk = 1'b0;

        // layer 1: 64 pixels
        for (img_idx = 0; img_idx < 64; img_idx = img_idx + 4) begin
            rst = 1'b1;
            sel = 1'b0;
            count = 227;
            #(`period*2);
            rst = 1'b0;
            #(`period);

            // generate path
            $sformat(img_path_1, "%s%1d.bmp", `IMG_PATH_BASE_1, img_idx);
            $sformat(img_path_2, "%s%1d.bmp", `IMG_PATH_BASE_1, img_idx+1);
            $sformat(img_path_3, "%s%1d.bmp", `IMG_PATH_BASE_1, img_idx+2);
            $sformat(img_path_4, "%s%1d.bmp", `IMG_PATH_BASE_1, img_idx+3);
            $display("output to layer 1 file %d", img_idx);
            
            // open file
            img_out_1 = $fopen(img_path_1, "wb");
            img_out_2 = $fopen(img_path_2, "wb");
            img_out_3 = $fopen(img_path_3, "wb");
            img_out_4 = $fopen(img_path_4, "wb");

            // write header of output bmp file 
            for(header = 0; header < 54; header = header + 1) begin
                $fwrite(img_out_1, "%c", img_data[header]);
                $fwrite(img_out_2, "%c", img_data[header]);
                $fwrite(img_out_3, "%c", img_data[header]);
                $fwrite(img_out_4, "%c", img_data[header]);
            end
            
            // weight & bias
            for (jdx = 0; jdx < `weight_1_input_size; jdx = jdx+1) begin
                input_weight_1[jdx*16 +: 16] = weight_1_data[img_idx*`weight_1_input_size+jdx]; // 2d to 1d
                input_weight_2[jdx*16 +: 16] = weight_1_data[(img_idx+1)*`weight_1_input_size+jdx]; 
                input_weight_3[jdx*16 +: 16] = weight_1_data[(img_idx+2)*`weight_1_input_size+jdx]; 
                input_weight_4[jdx*16 +: 16] = weight_1_data[(img_idx+3)*`weight_1_input_size+jdx]; 
            end
            input_bias_1 = bias_1_data[img_idx];
            input_bias_2 = bias_1_data[img_idx+1];
            input_bias_3 = bias_1_data[img_idx+2];
            input_bias_4 = bias_1_data[img_idx+3];

            // exec    
            for(idx = 0; idx < `padding_img_size+1; idx = idx+1) begin
                pixel_1 = padding_img[2][idx];
                pixel_2 = padding_img[1][idx];
                pixel_3 = padding_img[0][idx];
                pixel_4 = 8'b0;
                #(`period);
                // write data
                if (en) begin
                    $fwrite(img_out_1, "%c%c%c", out_1, out_1, out_1); padding_img_after_layer1[img_idx][count] = out_1;
                    $fwrite(img_out_2, "%c%c%c", out_2, out_2, out_2); padding_img_after_layer1[img_idx+1][count] = out_2;
                    $fwrite(img_out_3, "%c%c%c", out_3, out_3, out_3); padding_img_after_layer1[img_idx+2][count] = out_3;
                    $fwrite(img_out_4, "%c%c%c", out_4, out_4, out_4); padding_img_after_layer1[img_idx+3][count] = out_4;
                    count = count+1;
                    while ((count>=0 && count<=225) || (count%226==0) || (count==225+(count/226)*226) || (count>=50849 && count<=51075)) count = count+1;
                end
            end

            // close file
            $fclose(img_out_1);
            $fclose(img_out_2);
            $fclose(img_out_3);
            $fclose(img_out_4);
        end
        $fclose(bias_1);
        $fclose(weight_1);

        for (img_idx = 0; img_idx < 64; img_idx = img_idx + 4) begin
            rst = 1'b1;
            count = 0;
            sel = 1'b1;
            sel2 = 1'b0;
            #(`period*2);
            rst = 1'b0;
            #(`period);

            // generate path
            $sformat(img_path_1, "%s%1d.bmp", `IMG_PATH_BASE_2, img_idx);
            $sformat(img_path_2, "%s%1d.bmp", `IMG_PATH_BASE_2, img_idx+1);
            $sformat(img_path_3, "%s%1d.bmp", `IMG_PATH_BASE_2, img_idx+2);
            $sformat(img_path_4, "%s%1d.bmp", `IMG_PATH_BASE_2, img_idx+3);
            $display("output to layer 2 file %d", img_idx);
            
            // open file
            img_out_1 = $fopen(img_path_1, "wb");
            img_out_2 = $fopen(img_path_2, "wb");
            img_out_3 = $fopen(img_path_3, "wb");
            img_out_4 = $fopen(img_path_4, "wb");

            // write header of output bmp file 
            for(header = 0; header < 54; header = header + 1) begin
                $fwrite(img_out_1, "%c", img_data[header]);
                $fwrite(img_out_2, "%c", img_data[header]);
                $fwrite(img_out_3, "%c", img_data[header]);
                $fwrite(img_out_4, "%c", img_data[header]);
            end

            // bias
            input_bias_1 = bias_2_data[img_idx];
            input_bias_2 = bias_2_data[img_idx+1];
            input_bias_3 = bias_2_data[img_idx+2];
            input_bias_4 = bias_2_data[img_idx+3];

            // exec loop 16 times  
            for (jdx = 0; jdx < 64; jdx = jdx+4) begin
                // weight
                for (idx = 0; idx < `weight_2_input_size; idx = idx+1) begin
                    input_weight_1[idx*16 +: 16] = weight_2_data[jdx*9+idx+img_idx*576]; // 2d to 1d
                    input_weight_2[idx*16 +: 16] = weight_2_data[jdx*9+idx+img_idx*576+1*576]; 
                    input_weight_3[idx*16 +: 16] = weight_2_data[jdx*9+idx+img_idx*576+2*576]; 
                    input_weight_4[idx*16 +: 16] = weight_2_data[jdx*9+idx+img_idx*576+3*576]; 
                end

                if(count == 15) sel2 = 1'b1;
                $display("count: %d, sel2: %d", count, sel2);
                for(idx = 0; idx < `padding_img_size+1; idx = idx+1) begin
                    pixel_1 = padding_img_after_layer1[jdx][idx];
                    pixel_2 = padding_img_after_layer1[jdx+1][idx];
                    pixel_3 = padding_img_after_layer1[jdx+2][idx];
                    pixel_4 = padding_img_after_layer1[jdx+4][idx];
                    #(`period);
                    // write data
                    if (en & (count == 15)) begin
                        //$display("out success");
                        $fwrite(img_out_1, "%c%c%c", out_1, out_1, out_1);
                        $fwrite(img_out_2, "%c%c%c", out_2, out_2, out_2);
                        $fwrite(img_out_3, "%c%c%c", out_3, out_3, out_3);
                        $fwrite(img_out_4, "%c%c%c", out_4, out_4, out_4);
                    end
                end
                if(count == 15) begin 
                    count = 0;
                    sel2 = 1'b0;
                end
                else count = count + 1;
            end

            // close file
            $fclose(img_out_1);
            $fclose(img_out_2);
            $fclose(img_out_3);
            $fclose(img_out_4);
        end
        $fclose(bias_2);
        $fclose(weight_2);
        $finish;
    end
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    always begin
		#(`period/2.0) clk <= ~clk;
	end
    /*
    initial begin
		$sdf_annotate (`path_sdf, <your instance name>);
	end
    */
endmodule