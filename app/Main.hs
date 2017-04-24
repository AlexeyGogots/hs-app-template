module Main where

import Arbor.Logger
import Control.Lens
import Control.Monad.Logger    (LogLevel (..))
import Control.Monad.Trans.AWS
import Network.AWS.S3.Types    (Region (..))
import System.IO               (stdout)

import App.Application
import App.AppState
import App.Options


main :: IO ()
main = do
  opt <- parseOptions
  env <- mkEnv opt
  _ <- runGeoMute opt env
  putStrLn "Exiting."

runGeoMute :: HasEnv e => Options -> e -> IO AppState
runGeoMute opt env =
  runApplication env opt $ do
    logInfo "GeoMute is running."
    logInfo "Implement me, good bye."


mkEnv :: Options -> IO Env
mkEnv opt = do
  lgr <- newLogger (awsLogLevel opt) stdout
  newEnv Discover <&> (envLogger .~ lgr) . set envRegion (opt ^. optRegion)