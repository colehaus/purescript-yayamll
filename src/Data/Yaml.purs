module Data.Yaml (parseFromYaml, printToYaml) where

import Data.Argonaut.Core (Json)
import Data.Either (Either(..))
import Data.Function.Uncurried (Fn3, runFn3)

foreign import parseFromYamlImpl :: forall l r. Fn3 (l -> Either l r) (r -> Either l r) String (Either String Json)

-- | Parse a YAML string, consulting the `Json` value described by the string.
parseFromYaml :: String -> Either String Json
parseFromYaml = runFn3 parseFromYamlImpl Left Right

-- | Converts a `Json` value to a YAML string.
foreign import printToYaml :: Json -> String
