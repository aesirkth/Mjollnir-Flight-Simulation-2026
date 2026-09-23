function rocket = HIL_out(rocket, declare_dependencies)


if declare_dependencies

rocket.to_server = parallel.pool.PollableDataQueue(Destination="any");

else




if rocket.to_server.QueueLength == 0
send(rocket.to_server, rmfield(rocket, 'to_server'));
end



end