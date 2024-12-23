defmodule Mix.Helpers.IO do
  @moduledoc """
  Helper functions for console IO messages and user prompts.
  """

  @doc """
  Prints a message based on the fetch result.

  The second argument `available_modules` is needed to list the modules for the
  user in the case where an invalid command or module name is provided.
  """
  def print_result_message({:ok, :fetched}, _available_modules),
    do: Mix.Shell.IO.info("Exercises generated. Good luck!")

  def print_result_message({:ok, :complete}, _available_modules),
    do: Mix.Shell.IO.info("Nothing to generate. You have all available exercises!")

  def print_result_message({:error, :aborted}, _available_modules),
    do: Mix.Shell.IO.info("Aborted")

  def print_result_message({:error, _}, available_modules),
    do: Mix.Helpers.IO.print_options(available_modules)

  @doc """
  Prompts the user to download the next module. Returns a boolean.
  """
  def confirm_download?(next_module) do
    Mix.Shell.IO.info(
      "Based on what you have saved in your project, " <>
        "the next module to fetch is:\n\n#{next_module}\n"
    )

    Mix.Shell.IO.yes?("Proceed to generate exercises for this module?")
  end

  @doc """
  Prints an error message with the available modules to fetch.
  """
  def print_options(available_modules) do
    info_block_output()

    Mix.Shell.IO.info("Available options are:\n")
    Enum.map(available_modules, &Mix.Shell.IO.info/1)
    Mix.Shell.IO.info("")
  end

  defp info_block_output() do
    Mix.Shell.IO.error("** Error: invalid command")

    Mix.Shell.IO.info("""

    Spirit Gen needs to run with one string argument for the exercise to download
    Each string argument should be snake case
    Either no arg was provided or there was no match

    Example: basic_types
    """)
  end
end
