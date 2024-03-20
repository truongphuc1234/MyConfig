{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_my_xmobar (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/phuc/.config/xmobar/.stack-work/install/x86_64-linux/9c7bcc6d5d9bd0b27c6d16d9071c63d97e1247ae200c05bb24b621778b305a94/9.6.4/bin"
libdir     = "/home/phuc/.config/xmobar/.stack-work/install/x86_64-linux/9c7bcc6d5d9bd0b27c6d16d9071c63d97e1247ae200c05bb24b621778b305a94/9.6.4/lib/x86_64-linux-ghc-9.6.4/my-xmobar-0.0.0-JrULYv7Sxc5F1lCS79Tm0D"
dynlibdir  = "/home/phuc/.config/xmobar/.stack-work/install/x86_64-linux/9c7bcc6d5d9bd0b27c6d16d9071c63d97e1247ae200c05bb24b621778b305a94/9.6.4/lib/x86_64-linux-ghc-9.6.4"
datadir    = "/home/phuc/.config/xmobar/.stack-work/install/x86_64-linux/9c7bcc6d5d9bd0b27c6d16d9071c63d97e1247ae200c05bb24b621778b305a94/9.6.4/share/x86_64-linux-ghc-9.6.4/my-xmobar-0.0.0"
libexecdir = "/home/phuc/.config/xmobar/.stack-work/install/x86_64-linux/9c7bcc6d5d9bd0b27c6d16d9071c63d97e1247ae200c05bb24b621778b305a94/9.6.4/libexec/x86_64-linux-ghc-9.6.4/my-xmobar-0.0.0"
sysconfdir = "/home/phuc/.config/xmobar/.stack-work/install/x86_64-linux/9c7bcc6d5d9bd0b27c6d16d9071c63d97e1247ae200c05bb24b621778b305a94/9.6.4/etc"

getBinDir     = catchIO (getEnv "my_xmobar_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "my_xmobar_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "my_xmobar_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "my_xmobar_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "my_xmobar_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "my_xmobar_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
