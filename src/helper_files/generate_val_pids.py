from pathlib import Path
import random
import json

base_dir = Path("/cluster/work/climate/dnikolo/IceCloudNet_Data/Mid_lat_v2/TrainingData")
n_samples = 100

all_files = [str(p.relative_to(base_dir)) for p in base_dir.glob("*/*.nc")]
random_files = random.sample(all_files, n_samples)

print(json.dumps(random_files, indent=4))