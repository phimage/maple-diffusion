
import Foundation
import MapleDiffusion
import ArgumentParser

@main
struct MapleDiffusion: AsyncParsableCommand {

    @Option(name: .shortAndLong, help: "The model")
    var model: String

    @Option(name: .shortAndLong,help: "Output file")
    var output: String?

    @Argument(help: "The sentence")
    var prompt: String

    func run() async throws {
        let modelUrl = URL(fileURLWithPath: self.model)
        let outputURL = URL(fileURLWithPath: self.output ?? FileManager.default.currentDirectoryPath+"/image.png")
        let image = try await Diffusion.generate(localOrRemote: modelUrl, prompt: prompt)
        if let data = image?.pngData() {
            print("\(outputURL)")
            try data.write(to: outputURL)
        }
    }

}

import CoreGraphics
import CoreImage
import ImageIO

extension CGImage {

  public func pngData() -> Data? {
    let cfdata: CFMutableData = CFDataCreateMutable(nil, 0)
    if let destination = CGImageDestinationCreateWithData(cfdata, kUTTypePNG as CFString, 1, nil) {
      CGImageDestinationAddImage(destination, self, nil)
      if CGImageDestinationFinalize(destination) {
        return cfdata as Data
      }
    }

    return nil
  }
}
