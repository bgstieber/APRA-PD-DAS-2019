def create_md(filename,session,speaker):

	first_line = "# " + session + " - " + speaker

	rest = "## Notes \n \n \n" + "## Key Takeaways \n \n \n" + "## Other Details / Follow Up \n \n \n"

	full_file = first_line + "\n \n" + rest

	f = open(filename, "w+")

	f.write(full_file)

	f.close()


# create_md("foo_bar.md", "test session", "stieber")