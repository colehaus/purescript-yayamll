module Test.Main
  ( main
  ) where

import Prelude

import Data.Argonaut.Core (stringify)
import Data.Argonaut.Parser (jsonParser)
import Data.Either (Either(..))
import Data.Tuple (Tuple(..))
import Data.Tuple.Nested ((/\))
import Data.Yaml (parseFromYaml)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Test.Spec (describe, it)
import Test.Spec.Assertions (fail, shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (runSpec)

exampleYaml :: String
exampleYaml =
  """string: string
object:
  string: string
  int: 1
  float: 1.0
  object:
    string: string
    int: 1
    float: 1.0
text: |
  Lorem ipsum.
  Blah blah.
"""

exampleJson :: String
exampleJson =
  """{
       "string": "string",
       "object": {
         "string": "string",
         "int": 1,
         "float": 1.0,
         "object": {
           "string": "string",
           "int": 1,
           "float": 1.0
         }
       },
       "text": "Lorem ipsum.\nBlah blah.\n"
    }"""

main :: Effect Unit
main = launchAff_ $ runSpec [ consoleReporter ] do
  describe "YAMLL" do
    it "parses YAML to JSON representation" do
      let
        parsed = do
          yaml <- parseFromYaml exampleYaml
          json <- jsonParser exampleJson
          pure $ yaml /\ json
      case parsed of
        Right (Tuple yaml json) ->
          (stringify json) `shouldEqual` (stringify yaml)
        Left err -> fail $ "Malformed example: " <> err
