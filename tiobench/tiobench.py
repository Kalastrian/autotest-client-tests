import test
from autotest_utils import *

class tiobench(test.test):
	version = 1

	# http://prdownloads.sourceforge.net/tiobench/tiobench-0.3.3.tar.gz
	def setup(self, tarball = 'tiobench-0.3.3.tar.bz2'):
		tarball = unmap_url(self.bindir, tarball, self.tmpdir)
		extract_tarball_to_dir(tarball, self.srcdir)
		os.chdir(self.srcdir)

		system('make')
		
	def execute(self, dir, args = None):
		os.chdir(self.srcdir)
		if not args:
			args = '--block=4096 --block=8192 --threads=10 --size=1024 --numruns=2'
		system('./tiobench.pl --dir %s %s' %(dir, args))

		# Do a profiling run if necessary
		profilers = self.job.profilers
		if profilers.present():
			profilers.start(self)
			system('./tiobench.pl --dir %s %s' %(dir, args))
			profilers.stop(self)
			profilers.report(self)