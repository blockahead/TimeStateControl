function Kr = getCurvature(  t, Criteria, CurveConstant )
    CurvePoint = getCurvePoint( t, Criteria, CurveConstant );
    DiffCurvePoint = getDiffCurvePoint( t, Criteria, CurveConstant );
    DdiffCurvePoint = getDdiffCurvePoint( t, Criteria, CurveConstant );
    
    Kr = det( [ DiffCurvePoint, DdiffCurvePoint ] ) / ( norm( DiffCurvePoint )^3 );
end