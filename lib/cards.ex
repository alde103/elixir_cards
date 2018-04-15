defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello
      :world

  """
  def hello do
    "hi there!"
  end

  def create_dec do
    deck='A123456789JQK'
    deck_eng(deck)
  end

  def deck_eng([]) do
    []
  end

  def deck_eng([h|t]) do
    ["#{[h]}C"]++["#{[h]}E"]++["#{[h]}T"]++["#{[h]}D"]++deck_eng(t)
    # Corazones, Espadas, Treboles y Diamantes.
  end


  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contain?(deck,hand) do
    check_deck = fn (h) -> h in deck end
    res = Enum.map(hand, check_deck)
    Enum.all?(res)
  end

  def repartir(deck,0) do
    #regresando el mano y deck resultante.
    {deck,[]}
    #regresando la mano.
    #[]
  end

  def repartir(_deck,t_mano) when t_mano > 52 do
    IO.puts("Estas pidiendo una mano de #{t_mano} cartas y la baraja solo tiene 52 cartas")
  end

  def repartir(deck,t_mano) when t_mano <= 52 do
    size = length(deck)-1
    {:ok,nueva_carta} = Enum.fetch(deck,:rand.uniform(size))
    deck = deck--[nueva_carta]
    t_mano = t_mano-1

    #regresando el mano y deck resultante
    {deck, mano} = repartir(deck,t_mano)
    mano = mano ++ [nueva_carta]
    {deck,mano}

    #regresando solo la mano
    #nueva_carta = [nueva_carta] ++ repartir(deck,t_mano)
  end

  def save(deck,hand,filename) when is_bitstring(filename) do
    binary=:erlang.term_to_binary({deck,hand})
    File.write(filename,binary)
  end

  def save(_deck,_hand,_filename) do
    IO.puts("el nombre del archivo no es string")
  end

  def load(filename) when is_bitstring(filename) do
    {:ok, data}= File.read(filename)
    binary = :erlang.binary_to_term(data)
    binary
  end

  def load(_filename) do
    IO.puts("el nombre del archivo no es string")
  end

end
