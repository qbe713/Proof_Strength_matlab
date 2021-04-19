function [dl,F]=inverse_of_data_normalization(dl,F,normalization_data)
dl=(dl*(normalization_data(2)-normalization_data(1)))+normalization_data(1);
F=(F*(normalization_data(4)-normalization_data(3)))+normalization_data(3);
end