defmodule Cards do

  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Return a list of strings that represent a deck of playing cards
  """

  def create_deck do
      values = ["Ace", "Two", "Three", "Four", "Five"]
      suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

      for suit <- suits,  value <- values do
        "#{value} of #{suit}"
      end
    end
  
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a specific given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
      
  """
  def contains?(deck, card ) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of a deck.
    The `hand_size` argument indicates how many cards should be
    in the hand

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    # generate a tuple   
    Enum.split(deck, hand_size)
  end

  def save(deck, file_name) do
    binary = :erlang.term_to_binary(deck) # enconde to binary
    File.write(file_name, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> "Something went wrong: #{reason}" #enoent error is when file dosn't exist 
    end
  end

  def create_hand(hand_size) do
    create_deck()
    |> shuffle
    |> deal(hand_size)
  end
end
