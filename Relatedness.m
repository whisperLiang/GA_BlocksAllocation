% 
function relatedness_ij = Relatedness(i, j, dist, vehicles_customer)
    % n = size(dist, 1) - 1; % number of customer
    NV = size(vehicles_customer, 1); % number of vehicles
    d = dist(i + 1, j + 1);
    [md, ~] = max((dist(i + 1, 2 : end)));
    c = d / md; % distannce / max_distance
    V = 1; % not in the same route
    for k = 1 : NV
        route = vehicles_customer{k}; % all customers in Kth route
        findi = find(route == i, 1, 'first'); % return the position of customer if he is on this route
        findj = find(route == j, 1, 'first'); % 
        % if i and j are on the same route, v = 0
        if ~isempty(findi) && ~isempty(findj)
            V = 0;
        end
    end
    % relatedness is relative to the distance between 2 points and whether
    % they are on the same route
    relatedness_ij = 1 / (c + V);
end