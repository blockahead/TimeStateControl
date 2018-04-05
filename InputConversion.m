function delta = InputConversion( mu, z, th_diff, Kr, l )
    delta = atan( ( ( Kr * l ) / ( 1 - z * Kr ) ) * cos( th_diff ) + ( ( mu * l ) / ( cos( th_diff ) ) ) );
end