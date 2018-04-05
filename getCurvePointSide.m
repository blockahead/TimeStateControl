function Side = getCurvePointSide( Point, CurvePoint, DiffCurvePoint )
    % Normal vector
    Normal = ( CurvePoint - Point ) / norm( CurvePoint - Point );
    
    % Tangent vector
    if( norm( DiffCurvePoint ) < eps )
        Side = 1000;
        disp( 'Tangent vector invalid !' );
    else
        Tangent = DiffCurvePoint / norm( DiffCurvePoint );
        Side = sign( Normal(1) * Tangent(2) - Normal(2) * Tangent(1) );
    end
    
    if( abs( Side ) < eps )
        Side = 1;
    end
end