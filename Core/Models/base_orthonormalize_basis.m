function rocket = base_orthonormalize_basis(rocket, declare_dependencies)


if declare_dependencies



rocket.attitude = eye(3);


else



rocket.attitude = orthonormalize(rocket.attitude);




end
end