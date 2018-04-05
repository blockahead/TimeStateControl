function [ section_min, t_min ] = getNearestCurveParameter_AllSection( Point, x, y, NumOfSection, NumOfCriteria, CurveConstant )
    z_min = 1e9;
    t_min = 0;
    section_min = 1;
    
    for section_cnt = 1:NumOfSection
        Criteria = [ 
            x(section_cnt:section_cnt+(NumOfCriteria-1));
            y(section_cnt:section_cnt+(NumOfCriteria-1));
        ];

        t = getNearestCurveParameter( Point, Criteria, CurveConstant );

        CurvePoint = getCurvePoint( t, Criteria, CurveConstant );
        DiffCurvePoint = getDiffCurvePoint( t, Criteria, CurveConstant );

        z = getCurvePointDistance( Point, CurvePoint ) * getCurvePointSide( Point, CurvePoint, DiffCurvePoint );

        if( abs( z ) < abs( z_min ) )
            z_min = z;
            t_min = t;
            section_min = section_cnt;
        end
    end
end