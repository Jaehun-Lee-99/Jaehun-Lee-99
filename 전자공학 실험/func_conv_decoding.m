function decoded_bits_packet_rx = func_conv_decoding(received_bits_packet_rx)
    
    decoded_bits_packet_rx=zeros(length(received_bits_packet_rx)/2,1);
    
    V0=0; V1=0; V2=0; V3=0;    
    for ind = 1:length(decoded_bits_packet_rx)
        
        codeword=received_bits_packet_rx(2*ind-1:2*ind);
        metric_00=sum(double(codeword~=[0;0]));
        metric_01=sum(double(codeword~=[1;1]));
        metric_02=sum(double(codeword~=[0;1]));
        metric_03=sum(double(codeword~=[1;0]));
        metric_10=sum(double(codeword~=[1;1]));
        metric_11=sum(double(codeword~=[0;0]));
        metric_12=sum(double(codeword~=[1;0]));
        metric_13=sum(double(codeword~=[0;1]));
        if ind==1
            V0=metric_00;
            M0=[0];
            V2=metric_10;
            M2=[1];
        else
            if ind==2
                V0_t=V0+metric_00;
                M0_t=[M0;0];
                V1_t=V2+metric_02;
                M1_t=[M2;0];
                V2_t=V0+metric_10;
                M2_t=[M0;1];
                V3_t=V2+metric_12;
                M3_t=[M2;1];
            else
                % Compute path metric for each state
                %=======================================================================
                if V1+metric_01>=V0+metric_00
                    V0_t=V0+metric_00;
                    i0=2;
                else
                    V0_t=V1+metric_01;
                    i0=1;
                end
                if V3+metric_03>=V2+metric_02
                    V1_t=V2+metric_02;
                    i1=1;
                else
                    V1_t=V3+metric_03;
                    i1=2;
                end
                if V1+metric_11>=V0+metric_10
                    V2_t=V0+metric_10;
                    i2=1;
                else
                    V2_t=V1+metric_11;
                    i2=2;
                end
                if V3+metric_13>=V2+metric_12
                    V3_t=V2+metric_12;
                    i3=1;
                else
                    V3_t=V3+metric_13;
                    i3=2;
                end 
                %=======================================================================
                M0_t=[M1*(i0==1)+M0*(i0==2);0];
                M1_t=[M2*(i1==1)+M3*(i1==2);0];
                M2_t=[M0*(i2==1)+M1*(i2==2);1];
                M3_t=[M2*(i3==1)+M3*(i3==2);1];
            end
            V0=V0_t; M0=M0_t;
            V1=V1_t; M1=M1_t;
            V2=V2_t; M2=M2_t;
            V3=V3_t; M3=M3_t;
            
        end
    end
% Find the decoder output by comparing the final path metrics
%=======================================================================
m=min([V0 V1 V2 V3]);
if V0==m
    decoded_bits_packet_rx = M0;
elseif V1==m
    decoded_bits_packet_rx = M1;
elseif V2==m
    decoded_bits_packet_rx = M2;
elseif V3==m
    decoded_bits_packet_rx = M3;
end
%=======================================================================    
end