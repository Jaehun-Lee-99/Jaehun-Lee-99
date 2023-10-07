% DO NOT MODIFY THIS FILE

Order = ["0"; "1"; "2"; "fro"; "inf"];
    
%% custom vs built-in norm function for vectors
x = [1 2 3 -5 2 0 0 -7];

Custom_vector = [
    norm_ord(x, 0); ...
    norm_ord(x, 1); ...
    norm_ord(x, 2); ...
    NaN; ...
    norm_ord(x, 'inf'); ...
];

Built_in_vector = [
    nnz(x); ...  % (=norm(x, 0)) 
    norm(x, 1); ...
    norm(x, 2); ...
    NaN; ...
    norm(x, 'inf'); ...
];

%% custom vs built-in norm function for matrices
x = [1 2 3; 4 4 4; 5 6 7; 8 2 9];

Custom_matrix = [
    NaN; ...
    norm_ord(x, 1); ...
    norm_ord(x, 2); ...
    norm_ord(x, 'fro'); ...
    norm_ord(x, 'inf'); ...
];

Built_in_matrix = [
    NaN; ...
    norm(x, 1); ...
    norm(x, 2); ...
    norm(x, 'fro'); ...
    norm(x, 'inf'); ...
];

%% custom vs build-in condition number
x = [1 2 3 2; 4 4 4 1; 5 6 5 7; 8 2 2 9];

Custom_cond = [
    NaN; ...
    cond_num(x, 1); ...
    cond_num(x, 2); ...
    cond_num(x, 'fro'); ...
    cond_num(x, 'inf'); ...
];

Built_in_cond = [
    NaN; ...
    cond(x, 1); ...
    cond(x, 2); ...
    cond(x, 'fro'); ...
    cond(x, 'inf'); ...
];

%%
table(Order, Custom_vector, Built_in_vector, Custom_matrix, Built_in_matrix, Custom_cond, Built_in_cond)
