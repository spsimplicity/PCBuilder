function handleComplete(request)
{
	var instruction = request.getResponseHeader('X-Instruction')
	if(instruction == "error")
	{
		$('Signup').innerHTML = request.responseTest
	}
	else
	{
		window.location.reload(false)
	}
}