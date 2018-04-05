function distance = getDistanceError( Point, t, Criteria, CurveConstant )
    CurvePoint = getCurvePoint( t, Criteria, CurveConstant );
    DiffCurvePoint = getDiffCurvePoint( t, Criteria, CurveConstant );

    distance = getCurvePointDistance( Point, CurvePoint ) * getCurvePointSide( Point, CurvePoint, DiffCurvePoint );
end