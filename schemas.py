#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "click",
#     "genson",
#     "pydantic",
#     "rich-click",
# ]
# ///
import json
import os

import rich_click as click
from typing import List, Optional
from pydantic import BaseModel, Field
from pydantic.config import ConfigDict


class AsdfPkgs(BaseModel):
    """The asdf plugins to configure."""

    model_config = ConfigDict(title="asdf_packages")

    name: str = Field(
        title="asdf_plugin_name",
        description="The name of the asdf plugin.",
    )
    cmd: str = Field(
        title="installed_command",
        description="The command that is installed by the plugin. (e.g., the asdf plugin _bat-extras_ installs the `batgrep` command.)",
    )
    version: Optional[str] = Field(
        title="asdf_plugin_version",
        description="The version of the plugin to install. If not specified, the latest version will be installed.",
        default=None,
    )


class RpmPkgs(BaseModel):
    """RPM packages and repos to install on RPM based linux distributions."""

    model_config = ConfigDict(title="rpm_packages_and_repos")

    repos: List[str] = Field(
        title="rpm_repositories",
        description="List of RPM repositories to add. (e.g., https://download.docker.com/linux/centos/docker-ce.repo)",
    )
    coprs: List[str] = Field(
        title="copr_repositories",
        description="List of COPR repositories to add. (e.g., atim/lazygit)",
    )
    rpms: List[str] = Field(
        title="rpm_packages",
        description="List of RPM packages to install. (e.g., docker-ce, lazygit, etc.)",
    )


class LinuxPkgs(BaseModel):
    """Packages to install on any Linux distribution."""

    model_config = ConfigDict(title="linux_packages")

    fonts: List[str] = Field(
        title="fonts",
        description="List of fonts to install. These will be downloaded from https://www.nerdfonts.com/.",
    )
    flatpaks: List[str] = Field(
        title="flatpaks",
        description="List of Flatpak packages to install. These will be installed via the official flatpak repo (not distro specific repos).",
    )


class MasPkgs(BaseModel):
    """macOS App Store Apps to install via mas."""

    model_config = ConfigDict(title="macos_app")

    name: str = Field(
        title="app_name",
        description="The official name of the app. You can find this by running `mas search <app name>`.",
    )
    id: int = Field(
        title="app_id",
        description="The official App Store ID of the app. You can find this by running `mas search <app name>`.",
    )


class MacosPkgs(BaseModel):
    """Homebrew Packages and Taps and App Store apps to install on macOS."""

    model_config = ConfigDict(title="macos_packages")

    taps: List[str] = Field(
        title="homebrew_taps",
        description="List of Homebrew taps to add.",
    )
    casks: List[str] = Field(
        title="homebrew_casks",
        description="List of Homebrew casks to install.",
    )
    brews: List[str] = Field(
        title="homebrew_packages",
        description="List of Homebrew packages to install.",
    )
    mas: List[MasPkgs] = Field(
        title="macos_apps",
        description="List of macOS App Store apps to install via mas.",
    )


class Pkgs(BaseModel):
    """The root object for the packages schema."""

    model_config = ConfigDict(title="pkgs")

    crates: List[str] = Field(
        title="rust_crates",
        description="List of rust crates from https://crates.io to install.",
    )
    gopkgs: List[str] = Field(
        title="go_packages",
        description="List of Go packages to install.",
    )
    python: List[str] = Field(
        title="python_packages",
        description="List of Python packages to install. These will be installed via uv tools.",
    )
    scripts: List[str] = Field(
        title="scripts",
        description="List of shell scripts to run.",
    )
    python_scripts: List[str] = Field(
        title="python_scripts",
        description="List of Python scripts to run.",
    )
    asdf: List[AsdfPkgs] = Field(
        title="asdf_plugins",
        description="List of asdf plugins to install.",
    )
    rpm: RpmPkgs
    linux: LinuxPkgs
    macos: MacosPkgs


class Packages(BaseModel):
    """The list of packages to be installed by chezmoi."""

    model_config = ConfigDict(
        title="packages",
        json_schema_extra={
            "$schema": "https://json-schema.org/draft/2020-12/schema",
            "$id": "https://raw.githubusercontent.com/annie444/dotfiles/main/packages.schema.json",
        },
    )

    packages: Pkgs


class Files(object):
    def __init__(self, output: Optional[str] = None, pretty: bool = False):
        self.output = output
        self.pretty = pretty


pass_io = click.make_pass_decorator(Files, ensure=True)


@click.group(no_args_is_help=True, invoke_without_command=False)
@click.option(
    "--output",
    "-o",
    type=click.Path(
        file_okay=True,
        dir_okay=True,
        readable=True,
        writable=True,
        exists=False,
        resolve_path=True,
        allow_dash=True,
        path_type=str,
    ),
    default=None,
    help="The output directory to write the generated files to. If not specified, the files will be printed to stdout.",
)
@click.option(
    "--pretty",
    "-p",
    type=bool,
    is_flag=True,
    default=False,
    help="Whether to pretty print the JSON output.",
)
@pass_io
def main(io: Files, output: Optional[str] = None, pretty: bool = False) -> None:
    """Generate JSON schemas for chezmoi data files."""
    io.output = output
    io.pretty = pretty
    if output is not None:
        if not os.path.exists(os.path.dirname(output)):
            os.makedirs(os.path.dirname(output), exist_ok=True)
        if not (
            output.endswith("json")
            or output.endswith("jsonc")
            or output.endswith("schema")
        ):
            io.output = os.path.join(output, "packages.schema.json")


@main.command("packages")
@pass_io
def packages_schema(io: Files) -> None:
    """Generate the JSON schema for the Packages data."""
    pkgs_schema = Packages.model_json_schema(mode="validation")
    if io.output is not None:
        with click.open_file(filename=io.output, mode="w", encoding="utf-8") as f:
            if io.pretty:
                f.write(json.dumps(pkgs_schema, indent=2))
            else:
                f.write(json.dumps(pkgs_schema))
    else:
        if io.pretty:
            click.echo(json.dumps(pkgs_schema, indent=2))
        else:
            click.echo(json.dumps(pkgs_schema))


if __name__ == "__main__":
    main()
