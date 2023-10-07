function encoded_bits_packet_tx = func_conv_coding(bits_packet_tx)

    encoded_bits_packet_tx=zeros(length(bits_packet_tx)*2,1);
    
    % initial state
    state_0=0;
    state_1=0;
    
    A=[1 0 1];
    B=[1 1 1];

    
    for ind=1:length(bits_packet_tx)

        % encoded bits
        %=======================================================================
        register = [bits_packet_tx(ind); state_0; state_1];
        output_1 = A*register;
        output_2 = B*register;
        
        if output_2 == 3
            output_2 = 1;
        elseif output_2 == 2
            output_2 = 0;
        end
        if output_1 == 2
            output_1 = 0;
        end

        %=======================================================================
       
        % memory update
        %=======================================================================
        state_1 = state_0;
        state_0 = bits_packet_tx(ind);
        
        output = [output_1; output_2];
        encoded_bits_packet_tx( (ind-1)*2+1: ind*2) = output;
        %=======================================================================
    end
end
