% t         : Arc length parameter
% points    : Index of Criteria of curves [ x(4), y(4) ]
function CurvePoint = getCurvePoint( t, Criteria, CurveConstant )
    t_vector = [ t^3;t^2;t^1;t^0 ];
    
    CurvePoint = Criteria * CurveConstant * t_vector;
end